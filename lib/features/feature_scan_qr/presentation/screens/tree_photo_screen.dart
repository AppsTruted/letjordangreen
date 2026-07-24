import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:geolocator/geolocator.dart';
import 'package:letjordangreen/core/hive/user.dart';
import 'package:letjordangreen/features/feature_projects/cubits/projects_cubit.dart';
import 'dart:math' as math;
import 'package:letjordangreen/features/feature_scan_qr/cubits/scan_qr_cubit/scan_qr_cubit.dart';
import 'package:letjordangreen/features/feature_user_information/cubits/user_information_cubit/user_information_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class TreePhotoScreen extends StatefulWidget {
  final String qrCode;

  const TreePhotoScreen({
    super.key,
    required this.qrCode,
  });

  @override
  State<TreePhotoScreen> createState() => _TreePhotoScreenState();
}

class _TreePhotoScreenState extends State<TreePhotoScreen> {
  CameraController? _cameraController;
  List<CameraDescription>? _cameras;
  bool _isCameraInitialized = false;
  XFile? _capturedImage;
  bool _isUploading = false;
  String? _uploadStatus;

  UserInformationCubit userInformationCubit = UserInformationCubit();
  late UserHiveModel userHiveModel;
  // GPS Tracking
  Position? _startPosition;
  Position? _endPosition;
  bool _isGpsTracking = false;
  bool _hasGpsPermission = false;
  StreamSubscription<Position>? _positionStream;
  Timer? _gpsUpdateTimer;

  // Anti-fraud constants
  static const double MAX_ALLOWED_DISTANCE_METERS = 100.0;
  static const int MAX_STRIKES_BEFORE_LOCK = 3;

  // State
  int _dailyScanCount = 0;
  int _currentStrikes = 0;
  bool _isFarmerActive = true;
  String? _authToken;

  @override
  void initState() {
    super.initState();
    userHiveModel = userInformationCubit.state.userHiveModel;
    _initializeCamera();
    _requestPermissionsAndStartGps();
    _loadAuthToken();
  }

  Future<void> _loadAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _authToken = prefs.getString('auth_token');
    });
  }

  Future<void> _requestPermissionsAndStartGps() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() => _hasGpsPermission = false);
        _showPermissionError('Location permission denied');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() => _hasGpsPermission = false);
      _showPermissionError('Location permission permanently denied');
      return;
    }

    setState(() => _hasGpsPermission = true);
    _startGpsTracking();
  }

  void _showPermissionError(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('⚠️ $message'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 5),
        ),
      );
    }
  }

  void _startGpsTracking() {
    if (!_hasGpsPermission) return;

    setState(() {
      _isGpsTracking = true;
    });

    _getCurrentPosition();

    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.bestForNavigation,
      distanceFilter: 1,
      timeLimit: Duration(seconds: 5),
    );

    _positionStream = Geolocator.getPositionStream(
      locationSettings: locationSettings,
    ).listen((Position position) {
      if (mounted) {
        setState(() {
          _endPosition = position;
        });
      }
    });

    _gpsUpdateTimer = Timer(const Duration(seconds: 10), () {
      if (_startPosition == null) {
        _getCurrentPosition();
      }
    });
  }

  Future<void> _getCurrentPosition() async {
    try {
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation,
        timeLimit: const Duration(seconds: 10),
      );
      if (mounted) {
        setState(() {
          _startPosition ??= position;
          _endPosition = position;
        });
      }
    } catch (e) {
      print('Error getting position: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('⚠️ Unable to get GPS. Please enable location.'),
            backgroundColor: Colors.orange,
          ),
        );
      }
    }
  }

  Future<void> _initializeCamera() async {
    try {
      _cameras = await availableCameras();
      if (_cameras != null && _cameras!.isNotEmpty) {
        _cameraController = CameraController(
          _cameras![0],
          ResolutionPreset.high,
          enableAudio: false,
        );
        await _cameraController!.initialize();
        if (mounted) {
          setState(() {
            _isCameraInitialized = true;
          });
        }
      }
    } catch (e) {
      print('Camera initialization error: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Camera error: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _takePicture() async {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return;
    }

    try {
      if (_hasGpsPermission) {
        final endPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.bestForNavigation,
          timeLimit: const Duration(seconds: 5),
        );
        setState(() {
          _endPosition = endPosition;
        });
      }

      final XFile file = await _cameraController!.takePicture();

      setState(() {
        _capturedImage = file;
        _uploadStatus = null;
      });

      _logGpsData();

    } catch (e) {
      print('Error taking picture: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error taking photo: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  double _calculateDistance(Position start, Position end) {
    const double earthRadiusMeters = 6371000;

    double dLat = _degreesToRadians(end.latitude - start.latitude);
    double dLon = _degreesToRadians(end.longitude - start.longitude);

    double a = _sinSquared(dLat / 2) +
        math.cos(_degreesToRadians(start.latitude)) *
            math.cos(_degreesToRadians(end.latitude)) *
            _sinSquared(dLon / 2);

    double c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
    return earthRadiusMeters * c;
  }

  double _degreesToRadians(double degrees) => degrees * math.pi / 180;
  double _sinSquared(double x) => math.sin(x) * math.sin(x);

  void _logGpsData() {
    if (_startPosition != null && _endPosition != null) {
      final distance = _calculateDistance(_startPosition!, _endPosition!);
      print('📊 GPS Distance: ${distance.toStringAsFixed(2)}m');
      print('📍 Start: ${_startPosition!.latitude}, ${_startPosition!.longitude}');
      print('📍 End:   ${_endPosition!.latitude}, ${_endPosition!.longitude}');
      print('⚠️ Fraud threshold: ${distance <= MAX_ALLOWED_DISTANCE_METERS ? "✅ PASSED" : "❌ FAILED"}');
    } else {
      print('⚠️ GPS data missing!');
    }
  }

  Future<void> _retakePicture() async {
    setState(() {
      _capturedImage = null;
      _uploadStatus = null;
    });
  }

  // FIXED: Complete upload function with multipart form data
  Future<void> _uploadTreePhoto() async {
    if (_capturedImage == null) {
      _showSnackBar('Please take a photo first', Colors.orange);
      return;
    }

    if (_startPosition == null || _endPosition == null) {
      _showSnackBar('⚠️ GPS signal lost. Please try again.', Colors.red);
      return;
    }

    final distance = _calculateDistance(_startPosition!, _endPosition!);
    if (distance > MAX_ALLOWED_DISTANCE_METERS) {
      _showSnackBar(
        '⚠️ Distance ($distance m) exceeds 100m limit! Move closer to planting location.',
        Colors.red,
        duration: 5,
      );
      return;
    }

    setState(() {
      _isUploading = true;
      _uploadStatus = null;
    });

    try {
      // Use a completer to wait for the cubit's response
      final result = await context.read<ScanQrCubit>().scanQrFunction(
          context,
          startLat: _startPosition!.latitude.toString(),
          startLng: _startPosition!.longitude.toString(),
          endLat: _endPosition!.latitude.toString(),
          endLng: _endPosition!.longitude.toString(),
          capturedImage: _capturedImage
      );

      // Check the result for errors
      if (result != null && result.containsKey('message')) {
        final message = result['message'] ?? '';

        if (message.contains('already been used')) {
          setState(() {
            _isUploading = false;
            _uploadStatus = '❌ This QR code has already been used';
          });
          _showSnackBar('This QR code has already been used.', Colors.orange);
          return;
        }

        if (result.containsKey('strikes')) {
          setState(() {
            _currentStrikes = result['strikes'] ?? 0;
            _isFarmerActive = result['active'] ?? true;
          });
        }
      }

      // If we get here, it was successful
      setState(() {
        _isUploading = false;
        _uploadStatus = '✅ Order sent successfully!';
      });

      // _showSnackBar('✅ Tree planted successfully!', Colors.green);
      _showSuccessDialog("The world needs more people like you. Your trees are on the move—and so is the change you're creating");
     // context.read<ProjectsCubit>().getProjects();

      // Navigate back after success
      // Future.delayed(const Duration(seconds: 2), () {
      //   if (mounted) {
      //     Navigator.pop(context, true);
      //     Navigator.pop(context, true);
      //   }
      // });

    } catch (e) {
      print('❌ Upload error: $e');
      setState(() {
        _isUploading = false;
        _uploadStatus = '❌ Error: ${e.toString()}';
      });
      _showSnackBar('Error: ${e.toString()}', Colors.red);
    }
  }

  void _showSuccessDialog(String message) {
    // Grab the navigator using the SCREEN's context, before the dialog exists.
    final navigator = Navigator.of(context);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {   // renamed to avoid shadowing
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.green[50],
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 60,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  '🎉 Success!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(dialogContext).pop(); // close ONLY the dialog


                        if (mounted) {
                          navigator.pop(); // pop screen
                          navigator.pop(); // pop again if you really need two
                        }

                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'OK',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  void _showSnackBar(String message, Color backgroundColor, {int duration = 3}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        duration: Duration(seconds: duration),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    _positionStream?.cancel();
    _gpsUpdateTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        leadingWidth: 42,
        title: Text('Plant Tree - ${widget.qrCode}', style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white),),
        backgroundColor: Colors.green[900],
        foregroundColor: Colors.white,
        actions: [
          // GPS Status Indicator
          Container(
            margin: const EdgeInsets.only(right: 8),
            child: Row(
              children: [
                Icon(
                  _hasGpsPermission && _startPosition != null
                      ? Icons.gps_fixed
                      : Icons.gps_off,
                  color: _hasGpsPermission && _startPosition != null
                      ? Colors.green
                      : Colors.red,
                  size: 20,
                ),
                if (_startPosition != null && _endPosition != null) ...[
                  const SizedBox(width: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '${_calculateDistance(_startPosition!, _endPosition!).toStringAsFixed(0)}m',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white70,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          // Strikes indicator
          if (_currentStrikes > 0)
            Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: _currentStrikes >= MAX_STRIKES_BEFORE_LOCK
                    ? Colors.red
                    : Colors.orange,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '⚠️ $_currentStrikes/$MAX_STRIKES_BEFORE_LOCK',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
      body: Container(
        color: Colors.black,
        child: _isUploading
            ? const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 20),
              Text(
                'Uploading tree photo...',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        )
            : Stack(
          children: [
            if (_capturedImage != null)
              Positioned.fill(
                child: Image.file(
                  File(_capturedImage!.path),
                  fit: BoxFit.cover,
                ),
              )
            else if (_isCameraInitialized && _cameraController != null)
              Positioned.fill(
                child: CameraPreview(_cameraController!),
              )
            else
              const Center(
                child: CircularProgressIndicator(),
              ),

            // GPS Status Overlay
            Positioned(
              top: 20,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Text(
                      _capturedImage == null
                          ? '📸 Position tree and take photo'
                          : '🔄 Photo captured - tap retake or upload',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    if (_startPosition != null && _endPosition != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        'GPS: ${_calculateDistance(_startPosition!, _endPosition!).toStringAsFixed(1)}m',
                        style: TextStyle(
                          color: _calculateDistance(_startPosition!, _endPosition!) <= MAX_ALLOWED_DISTANCE_METERS
                              ? Colors.green
                              : Colors.red,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),

            // Status message
            if (_uploadStatus != null)
              Positioned(
                top: 100,
                left: 20,
                right: 20,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: _uploadStatus!.contains('✅')
                        ? Colors.green.withOpacity(0.9)
                        : _uploadStatus!.contains('⚠️')
                        ? Colors.orange.withOpacity(0.9)
                        : Colors.red.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    _uploadStatus!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

            // Bottom action buttons
            Positioned(
              bottom: 40,
              left: 20,
              right: 20,
              child: Column(
                children: [
                  if (_capturedImage != null) ...[
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: _retakePicture,
                            icon: const Icon(Icons.refresh),
                            label: const Text('RETAKE'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey[800],
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                vertical: 15,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: _uploadTreePhoto,
                            icon: const Icon(Icons.cloud_upload),
                            label: const Text('UPLOAD'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green[700],
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                vertical: 15,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ] else ...[
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: _takePicture,
                        icon: const Icon(Icons.camera_alt, size: 26),
                        label: const Text(
                          'TAKE PHOTO',
                          style: TextStyle(fontSize: 16),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.green[900],
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(height: 10),
                  // Info text
                  Text(
                    'GPS accuracy: ${_endPosition?.accuracy?.toStringAsFixed(0) ?? '...'}m',
                    style: const TextStyle(
                      color: Colors.white54,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}