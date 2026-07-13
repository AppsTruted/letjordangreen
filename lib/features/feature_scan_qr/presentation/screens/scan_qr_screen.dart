import 'dart:math' as math;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:letjordangreen/core/functions/current_location.dart';
import 'package:letjordangreen/features/feature_scan_qr/cubits/scan_qr_cubit/scan_qr_cubit.dart';
import 'package:letjordangreen/features/feature_scan_qr/presentation/screens/tree_photo_screen.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class TreeScannerScreen extends StatefulWidget {
  const TreeScannerScreen({
    super.key,
    this.onReadySubmit,
  });

  final void Function(String qrValue, Uint8List? capturedImage)? onReadySubmit;

  @override
  State<TreeScannerScreen> createState() => _TreeScannerScreenState();
}

class _TreeScannerScreenState extends State<TreeScannerScreen> {
  late final MobileScannerController _controller;

  String? _qrValue;
  Uint8List? _capturedImage;
  bool _scanLocked = false;
  bool _gpsLocked = true;
  bool _systemOnline = true;
  static const Color darkGreen = Color(0xff00451f);
  static const Color cream = Color(0xfff7eedc);
  static const Color mutedGreen = Color(0xff7d805f);
  static const Color textDark = Color(0xff26251d);

  bool get _isReady => _qrValue != null;

  @override
  void initState() {
    super.initState();
    initLocation();
    _controller = MobileScannerController(
      formats: const [BarcodeFormat.qrCode],
      detectionSpeed: DetectionSpeed.normal,
      detectionTimeoutMs: 600,
      facing: CameraFacing.back,
      returnImage: true,
      autoZoom: true,
    );
  }

  initLocation() async {
    final location = await getUserCurrentLocation();
    context.read<ScanQrCubit>().setStartLat(location?.latitude.toString()??"");
    context.read<ScanQrCubit>().setStartLng(location?.longitude.toString()??"");
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onDetect(BarcodeCapture capture) {
    if (_scanLocked || capture.barcodes.isEmpty) return;

    final barcode = capture.barcodes.first;
    final value = barcode.rawValue;

    if (value == null || value.isEmpty) return;

    HapticFeedback.mediumImpact();

    setState(() {
      _qrValue = value;
      _capturedImage = capture.image;
      _scanLocked = true;
    });
  }

  Future<void> _resetScanner() async {
    setState(() {
      _qrValue = null;
      _capturedImage = null;
      _scanLocked = false;
    });

    await _controller.start();
  }

  void _submitScan() async {
    if (!_isReady) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please scan a QR code first.')),
      );
      return;
    }

    // Release the camera session before opening a new one on the next screen
    await _controller.stop();

    if (!mounted) return;

    context.read<ScanQrCubit>().setUniqueCode(_qrValue??"");
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TreePhotoScreen(
          qrCode: _qrValue!,
        //  qrImage: _capturedImage,
        ),
      ),
    );

    if (result == true) {
      _resetScanner();
    } else {
      // came back without uploading — restart scanner camera
      await _controller.start();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.sizeOf(context);
    final topPadding = MediaQuery.paddingOf(context).top;

    final bottomPanelHeight = screen.height * 0.30;
    final frameSize = math.min(screen.width * 0.62, 255.0);
    final frameTop = topPadding + 125;

    final scanWindow = Rect.fromLTWH(
      (screen.width - frameSize) / 2,
      frameTop,
      frameSize,
      frameSize,
    );

    return Scaffold(
      backgroundColor: Colors.black,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: MobileScanner(
                controller: _controller,
                scanWindow: scanWindow,
                fit: BoxFit.cover,
                onDetect: _onDetect,
                errorBuilder: (context, error) {
                  return Container(
                    color: Colors.black,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(24),
                    child: Text(
                      error.errorDetails?.message ?? 'Camera error',
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                },
              ),
            ),

            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.18),
                      Colors.transparent,
                      Colors.black.withOpacity(0.32),
                    ],
                  ),
                ),
              ),
            ),

            Positioned(
              top: topPadding + 12,
              left: 32,
              right: 32,
              child: _TopBar(
                onBack: () => Navigator.pop(context),
                onTorch: () => _controller.toggleTorch(),
              ),
            ),

            Positioned(
              left: (screen.width - frameSize) / 2,
              top: frameTop,
              width: frameSize,
              height: frameSize,
              child: const _ScannerFrame(),
            ),

            Positioned(
              top: frameTop + frameSize + 34,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 22,
                    vertical: 13,
                  ),
                  decoration: BoxDecoration(
                    color: mutedGreen.withOpacity(0.86),
                    borderRadius: BorderRadius.circular(26),
                  ),
                  child: Text(
                    _isReady
                        ? 'QR code captured successfully'
                        : 'Align QR code within the frame',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
            if (_isReady)
              Positioned(
                left: 16,
                right: 16,
                bottom: bottomPanelHeight + 16,
                child: _DetectedTreePanel(
                  detectedId: _formatDetectedId(_qrValue),
                  gpsLocked: _gpsLocked,
                  systemOnline: _systemOnline,
                ),
              ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              height: bottomPanelHeight,
              child: Container(
                padding: const EdgeInsets.fromLTRB(16, 28, 16, 40),
                decoration: const BoxDecoration(
                  color: cream,
                ),
                child: Column(
                  children: [
                    _StatusCard(
                      isReady: _isReady,
                      capturedImage: _capturedImage,
                    ),

                    const Spacer(),

                    Row(
                      spacing: 16,
                      children: [
                        GestureDetector(
                          onTap: _resetScanner,
                          child: Container(
                            width: 102,
                            height: 44,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                color: const Color(0xff7d8279),
                                width: 1.8,
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                'RESET',
                                style: TextStyle(
                                  color: textDark,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.2,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: _submitScan,
                            child: Container(
                              height: 44,
                              decoration: BoxDecoration(
                                color: darkGreen,
                                borderRadius: BorderRadius.circular(28),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.22),
                                    blurRadius: 16,
                                    offset: const Offset(0, 9),
                                  ),
                                ],
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                    size: 22,
                                  ),
                                  SizedBox(width: 9),
                                  Text(
                                    'Next',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),



                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  String _formatDetectedId(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "#UNKNOWN";
    }

    final cleanedValue = value.trim();

    if (cleanedValue.startsWith("#")) {
      return cleanedValue;
    }

    return "#$cleanedValue";
  }
}
class _DetectedTreePanel extends StatelessWidget {
  final String detectedId;
  final bool gpsLocked;
  final bool systemOnline;

  const _DetectedTreePanel({
    required this.detectedId,
    required this.gpsLocked,
    required this.systemOnline,
  });

  static const Color darkGreen = Color(0xff00451f);
  static const Color accentGreen = Color(0xff4d8055);

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 260),
      child: Container(
        key: ValueKey(detectedId),
        padding: const EdgeInsets.fromLTRB(22, 20, 22, 20),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.72),
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: Colors.white.withOpacity(0.08),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.28),
              blurRadius: 22,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  color: gpsLocked ? accentGreen : Colors.orangeAccent,
                  size: 30,
                ),

                const SizedBox(width: 13),

                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        letterSpacing: -0.3,
                      ),
                      children: [
                        const TextSpan(text: "GPS: "),
                        TextSpan(
                          text: gpsLocked ? "LOCKED" : "SEARCHING",
                          style: TextStyle(
                            color: gpsLocked ? Colors.white : Colors.orangeAccent,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 17,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: systemOnline
                        ? accentGreen.withOpacity(0.22)
                        : Colors.red.withOpacity(0.18),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: systemOnline
                          ? accentGreen.withOpacity(0.42)
                          : Colors.red.withOpacity(0.38),
                      width: 1.2,
                    ),
                  ),
                  child: Text(
                     "Done",
                    style: TextStyle(
                      color: systemOnline ? Colors.white : Colors.red.shade200,
                      fontSize: 13,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 17,
              ),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.12),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: Colors.white.withOpacity(0.08),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.qr_code_2_rounded,
                    color: accentGreen.withOpacity(0.95),
                    size: 31,
                  ),

                  const SizedBox(width: 17),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "DETECTED Code".toUpperCase(),
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                        ),

                        const SizedBox(height: 5),

                        Text(
                          detectedId,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
                        ),
                      ],
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
class _TopBar extends StatelessWidget {
  const _TopBar({
    required this.onBack,
    required this.onTorch,
  });

  final VoidCallback onBack;
  final VoidCallback onTorch;

  static const Color circleColor = Color(0xff61734a);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _CircleIconButton(
          icon: Icons.arrow_back_rounded,
          onTap: onBack,
        ),

        const Expanded(
          child: Center(
            child: Text(
              'Scanner',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.4,
              ),
            ),
          ),
        ),

        _CircleIconButton(
          icon: Icons.flashlight_on_outlined,
          onTap: onTorch,
        ),
      ],
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  const _CircleIconButton({
    required this.icon,
    required this.onTap,
  });

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: const Color(0xff61734a).withOpacity(0.88),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 24,
        ),
      ),
    );
  }
}

class _ScannerFrame extends StatelessWidget {
  const _ScannerFrame();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _ScannerFramePainter(),
    );
  }
}

class _ScannerFramePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xff94cf9b)
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    const radius = 12.0;
    const cornerLength = 45.0;

    final path = Path();

    path.moveTo(radius, 0);
    path.lineTo(cornerLength, 0);
    path.moveTo(0, radius);
    path.lineTo(0, cornerLength);

    path.moveTo(size.width - cornerLength, 0);
    path.lineTo(size.width - radius, 0);
    path.quadraticBezierTo(size.width, 0, size.width, radius);
    path.moveTo(size.width, radius);
    path.lineTo(size.width, cornerLength);

    path.moveTo(0, size.height - cornerLength);
    path.lineTo(0, size.height - radius);
    path.quadraticBezierTo(0, size.height, radius, size.height);
    path.moveTo(radius, size.height);
    path.lineTo(cornerLength, size.height);

    path.moveTo(size.width - cornerLength, size.height);
    path.lineTo(size.width - radius, size.height);
    path.quadraticBezierTo(
      size.width,
      size.height,
      size.width,
      size.height - radius,
    );
    path.moveTo(size.width, size.height - radius);
    path.lineTo(size.width, size.height - cornerLength);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _StatusCard extends StatelessWidget {
  const _StatusCard({
    required this.isReady,
    required this.capturedImage,
  });

  final bool isReady;
  final Uint8List? capturedImage;

  static const Color darkGreen = Color(0xff00451f);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 78,
          height: 78,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: const Color(0xffedf1e8),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.white.withOpacity(0.85),
              width: 2,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(9),
            child: Stack(
              fit: StackFit.expand,
              children: [
                if (capturedImage != null)
                  Image.memory(
                    capturedImage!,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => _PhonePlaceholder(),
                  )
                else
                  const _PhonePlaceholder(),

                Center(
                  child: Container(
                    width: 33,
                    height: 33,
                    decoration: BoxDecoration(
                      color: isReady ? const Color(0xff5aa348) : Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                    child: isReady ? Icon(
                       Icons.check_rounded ,
                      color:  Colors.white ,
                      size: 21,
                    ) : Center(child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(strokeWidth: 1),
                    ),),
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(width: 16),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Text(
                'VERIFICATION STATUS',
                style: Theme.of(context).textTheme.bodyLarge,
              ),

              const SizedBox(height: 7),

              Row(
                children: [
                  Flexible(
                    child: Text(
                      isReady ? 'Ready to submit' : 'Waiting for scan',
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: darkGreen),
                    ),
                  ),
                  if (isReady) ...[
                    const SizedBox(width: 10),
                    Container(
                      width: 7,
                      height: 7,
                      decoration: const BoxDecoration(
                        color: Color(0xff4f8f42),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ],
              ),

              const SizedBox(height: 5),

              Text(
                isReady
                    ? 'Tree identified and photo captured.'
                    : 'Align QR code within the frame.',
                style: TextStyle(
                  color: Colors.black.withOpacity(0.45),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PhonePlaceholder extends StatelessWidget {
  const _PhonePlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffccd8ce),
      child: Center(
        child: Container(
          width: 36,
          height: 54,
          decoration: BoxDecoration(
            color: const Color(0xffdfe7df),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: const Color(0xff7c9b84),
              width: 1.2,
            ),
          ),
          child: Column(
            children: [
              Container(
                height: 9,
                decoration: const BoxDecoration(
                  color: Color(0xff315f3a),
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(5),
                  ),
                ),
              ),
              const Expanded(
                child: Icon(
                  Icons.qr_code_2_rounded,
                  color: Color(0xff315f3a),
                  size: 22,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}