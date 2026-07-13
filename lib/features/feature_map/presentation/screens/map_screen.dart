import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:letjordangreen/core/extension/capitalize_extension.dart';
import 'package:letjordangreen/core/functions/dissmiss_keybooard.dart';
import 'package:letjordangreen/core/states/base_states.dart';
import 'package:letjordangreen/core/utils/constants/app_colors.dart';
import 'package:letjordangreen/features/feature_map/cubit/public_map_cubit.dart';
import 'package:letjordangreen/features/feature_map/cubit/tree_cubit.dart';
import 'package:letjordangreen/features/feature_map/data/models/public_map_model.dart';
import 'package:letjordangreen/features/feature_map/data/models/tree_model.dart';
import 'package:letjordangreen/widgets/custom_text_form_field.dart';
import 'package:letjordangreen/widgets/url_launcher.dart';


class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _mapController;
  Set<Marker> _markers = {};
  bool _isFirstLoad = true;
  List<PublicMapModel>? _lastTrees;
  final TextEditingController _searchController = TextEditingController();
  bool _isSearchFocused = false;
  bool _isSearching = false;
  bool _isMapReady = false;
  bool _isDisposed = false;

  bool _markerAdded = false;

  static const CameraPosition _initialCamera = CameraPosition(
    target: LatLng(31.9539, 35.9106),
    zoom: 12,
    tilt: 45,
  );

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _isDisposed = true;
    _mapController?.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _buildMarkers(List<PublicMapModel> trees) async {
    if (_isDisposed || !mounted) return;

    final markers = <Marker>{};

    for (var i = 0; i < trees.length; i++) {
      final tree = trees[i];
      if (tree.lat == null || tree.lng == null) continue;

      markers.add(
        Marker(
          markerId: MarkerId('tree_$i'),
          position: LatLng(tree.lat!, tree.lng!),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueGreen,
          ),
          infoWindow: InfoWindow(title: 'Tree ${i + 1}'),
        ),
      );
    }

    if (_isDisposed || !mounted) return;
    setState(() => _markers = markers);

    if (_isDisposed || !mounted || !_isMapReady || _mapController == null) return;

    if (markers.isNotEmpty) {
      _fitBounds(markers);
      _isFirstLoad = false;
    } else if (markers.isEmpty && _isFirstLoad) {
      _animateCameraSafely(
        CameraUpdate.newCameraPosition(_initialCamera),
      );
      _isFirstLoad = false;
    }
  }

  void _animateCameraSafely(CameraUpdate cameraUpdate) {
    if (_isDisposed || !mounted || _mapController == null || !_isMapReady) return;

    try {
      _mapController?.animateCamera(cameraUpdate);
    } catch (e) {
      debugPrint('Error animating camera: $e');
    }
  }

  void _fitBounds(Set<Marker> markers) {
    if (_isDisposed || !mounted || markers.isEmpty || _mapController == null || !_isMapReady) return;

    if (markers.length == 1) {
      _animateCameraSafely(
        CameraUpdate.newLatLngZoom(markers.first.position, 15),
      );
      return;
    }

    double minLat = markers.first.position.latitude;
    double maxLat = markers.first.position.latitude;
    double minLng = markers.first.position.longitude;
    double maxLng = markers.first.position.longitude;

    for (final m in markers) {
      minLat = m.position.latitude < minLat ? m.position.latitude : minLat;
      maxLat = m.position.latitude > maxLat ? m.position.latitude : maxLat;
      minLng = m.position.longitude < minLng ? m.position.longitude : minLng;
      maxLng = m.position.longitude > maxLng ? m.position.longitude : maxLng;
    }

    _animateCameraSafely(
      CameraUpdate.newLatLngBounds(
        LatLngBounds(
          southwest: LatLng(minLat, minLng),
          northeast: LatLng(maxLat, maxLng),
        ),
        60,
      ),
    );
  }

  void _searchTree(String code) async {
    if (_isDisposed || !mounted) return;

    if (code.isEmpty) {
      _isSearching = false;
      _markerAdded = false; // Reset marker flag
      if (mounted) {
        setState(() {
          _isSearchFocused = false;
        });
      }
      context.read<PublicMapCubit>().getTreesOnMap();
      return;
    }

    // Reset marker flag before new search
    _markerAdded = false;

    if (mounted) {
      setState(() {
        _isSearching = true;
      });
    }

    context.read<TreeCubit>().getTree(code);
  }

  void _addSingleMarker(TreeModel tree) {
    if (_isDisposed || !mounted) return;
    if (tree.gpsLat == null || tree.gpsLng == null) return;
    if (_markerAdded) return; // Prevent adding marker multiple times

    _markerAdded = true; // Set flag to prevent multiple additions

    setState(() {
      _markers = {
        Marker(
          markerId: const MarkerId('searched_tree'),
          position: LatLng(tree.gpsLat!, tree.gpsLng!),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueRed,
          ),
          infoWindow: InfoWindow(
            title: 'Searched Tree',
            snippet: 'Code: ${tree.uniqueCode ?? 'N/A'}',
          ),
        ),
      };
    });

    _animateCameraSafely(
      CameraUpdate.newLatLngZoom(
        LatLng(tree.gpsLat!, tree.gpsLng!),
        16,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PublicMapCubit, BaseState<List<PublicMapModel>>>(
        builder: (context, mapState) {
          if (mapState is LoadingState) {
            return const Center(child: CircularProgressIndicator());
          }

          if (mapState is ErrorState) {
            return const Center(child: Text('Something went wrong'));
          }

          if (mapState is SuccessState<List<PublicMapModel>>) {
            final trees = mapState.data ?? [];

            if (!identical(trees, _lastTrees) && !_isSearching) {
              _lastTrees = trees;
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (!_isDisposed && mounted && !_isSearching) {
                  _buildMarkers(trees);
                }
              });
            }

            return Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: _initialCamera,
                  mapType: MapType.satellite,
                  markers: _markers,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  zoomControlsEnabled: true,
                  zoomGesturesEnabled: true,
                  scrollGesturesEnabled: true,
                  rotateGesturesEnabled: true,
                  tiltGesturesEnabled: true,
                  onMapCreated: (controller) {
                    _mapController = controller;
                    _isMapReady = true;
                    if (_markers.isNotEmpty && mounted) {
                      _fitBounds(_markers);
                      _isFirstLoad = false;
                    }
                  },
                ),

                // Search TextField - Top Center

                Positioned(
                  top: 90,
                  left: 16,
                  right: 16,
                  child: Row(
                    spacing: 2,
                    children: [
                      Expanded(
                        flex: 4,
                        child: CustomTextFormField(
                          textEditingController: _searchController,
                          onTap: () {
                            if (mounted) {
                              setState(() {
                                _isSearchFocused = true;
                              });
                            }
                          },
                          onChange: (value) {
                            if (mounted) setState(() {});
                          },
                          onSubmitted: (val){
                            _searchTree(_searchController.text.trim());
                            if (mounted) {
                              setState(() {
                                _isSearchFocused = false;
                              });
                              unFocusKeyBoard();
                            }
                          },
                          hintText: 'Enter tree code to search...',
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                          suffixIcon: _searchController.text.isNotEmpty
                              ? IconButton(
                            icon: const Icon(
                              Icons.clear,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              _searchController.clear();
                              _markerAdded = false;
                              if (mounted) setState(() {});
                              _isSearching = false;
                              context.read<PublicMapCubit>().getTreesOnMap();
                            },
                          )
                              : null,
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            _searchTree(_searchController.text.trim());
                            if (mounted) {
                              setState(() {
                                _isSearchFocused = false;
                              });
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.all(13),
                            child: const Center(
                              child: Row(
                                spacing: 4,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Go",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                    top: 35,
                    left: 17,
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(.6),
                            borderRadius: BorderRadius.circular(8)
                        ),
                        child: BackButton(color: Colors.black,))),

                // Search results dropdown showing the searched tree
                if (_isSearching)
                  Positioned(
                    top: 130,
                    left: 16,
                    right: 16,
                    child: BlocBuilder<TreeCubit, BaseState<TreeModel>>(
                      builder: (context, treeState) {
                        log("treeState ${treeState}");

                        if (treeState is LoadingState) {
                          return Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.15),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: const Center(
                              child: SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              ),
                            ),
                          );
                        }

                        if (treeState is SuccessState<TreeModel>) {
                          final tree = treeState.data;
                          if (tree != null && tree.uniqueCode != null) {
                            // Only add marker if not already added
                            if (!_markerAdded) {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                if (!_isDisposed && mounted && _isSearching) {
                                  _addSingleMarker(tree);
                                }
                              });
                            }

                            return Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.15),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  _buildSearchResultItem(
                                    'Tree Code: ${tree.uniqueCode ?? 'N/A'}',
                                    tree,
                                  ),
                                  if (_searchController.text.isNotEmpty)
                                    GestureDetector(
                                      onTap: () {
                                        _markerAdded = false;
                                        setState(() {
                                          _isSearching = false;
                                          _searchController.clear();
                                          _isSearchFocused = false;
                                        });
                                        context.read<PublicMapCubit>().getTreesOnMap();
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(vertical: 12),
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            top: BorderSide(color: Colors.grey, width: 0.5),
                                          ),
                                        ),
                                        child: const Center(
                                          child: Text(
                                            'Clear search',
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            );
                          } else {
                            _markerAdded = false;
                            return _buildNotFoundWidget();
                          }
                        }

                        if (treeState is ErrorState) {
                          _markerAdded = false;
                          return _buildNotFoundWidget();
                        }

                        return const SizedBox.shrink();
                      },
                    ),
                  ),

                // No trees found message
                if (trees.isEmpty && !_isSearching)
                  const Positioned(
                    bottom: 24,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Text(
                        'No trees found',
                        style: TextStyle(
                          color: Colors.white,
                          backgroundColor: Colors.black54,
                        ),
                      ),
                    ),
                  ),

                // Close button when search is focused
                if (_isSearchFocused)
                  Positioned(
                    top: 44,
                    right: 24,
                    child: GestureDetector(
                      onTap: () {
                        _markerAdded = false;
                        setState(() {
                          _isSearchFocused = false;
                          _isSearching = false;
                          _searchController.clear();
                        });
                        context.read<PublicMapCubit>().getTreesOnMap();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.close,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildNotFoundWidget() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          const Center(
            child: Text(
              'Tree not found',
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () {
              _markerAdded = false;
              setState(() {
                _isSearching = false;
                _searchController.clear();
                _isSearchFocused = false;
              });
              context.read<PublicMapCubit>().getTreesOnMap();
            },
            child: const Text(
              'Clear search',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResultItem(String title, TreeModel tree) {
    return Material(
      color: Colors.transparent,
      child: ListTile(
        leading: const Icon(Icons.pin_drop, color: Colors.green),
        title: Text(title),
        subtitle: tree.projectName != null
            ? Text(
          '📍 ${tree.projectName}',
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        )
            : null,
        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
        onTap: () {
          // Close search results and show bottom sheet with details
          setState(() {
            _isSearchFocused = false;
            _isSearching = false;
          });

          // Show tree details in a bottom sheet
          _showTreeDetailsBottomSheet(context, tree);
        },
      ),
    );
  }

  void _showTreeDetailsBottomSheet(BuildContext context, TreeModel tree) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.9,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, scrollController) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverAppBar(
                pinned: true,
                expandedHeight: 200.0,
                elevation: 0,
                backgroundColor: Colors.white,
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Show first image if available
                      tree.imageUrls != null && tree.imageUrls!.isNotEmpty
                          ? Image.network(
                        tree.imageUrls!.first,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            Container(color: Colors.grey[300]),
                      )
                          : Container(
                        color: Colors.grey[300],
                        child:  Icon(
                          Icons.forest,
                          size: 60,
                          color: Colors.grey,
                        ),
                      ),
                      // Gradient overlay for better text visibility
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.7),
                            ],
                          ),
                        ),
                      ),
                      // Status badge
                      Positioned(
                        top: 16,
                        right: 16,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: _getStatusColor(tree.status),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            tree.status?.capitalize()?.replaceAll("_", " ") ?? 'Unknown',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      // Tree code in header
                      Positioned(
                        bottom: 16,
                        left: 16,
                        right: 16,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tree.uniqueCode ?? 'N/A',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (tree.projectName != null)
                              Text(
                                tree.projectName!,
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 16,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    // Tree Details
                    _buildDetailSection(context, tree),
                    const SizedBox(height: 24),

                    // Image Gallery if multiple images
                    if (tree.imageUrls != null && tree.imageUrls!.length > 1)
                      _buildImageGallery(tree.imageUrls!),

                    const SizedBox(height: 24),

                    // Action Buttons
                    _buildActionButtons(context, tree),

                    const SizedBox(height: 40),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailSection(BuildContext context, TreeModel tree) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.eco,
                  color: Colors.green.shade700,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Tree Details',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1A1A2E),
                  letterSpacing: -0.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                _buildDetailRow(
                  Icons.pin_drop,
                  'Planting Zone',
                  tree.projectName ?? 'N/A',
                  iconColor: Colors.orange.shade600,
                ),
                _buildDivider(),
                _buildDetailRow(
                  Icons.person,
                  'Cared for by',
                  tree.farmerName ?? 'N/A',
                  iconColor: Colors.blue.shade600,
                ),
                _buildDivider(),
                _buildDetailRow(
                  Icons.person_outline,
                  'Planted for',
                  tree.beneficiaryName ?? 'N/A',
                  iconColor: Colors.purple.shade600,
                ),
                _buildDivider(),
                _buildDetailRow(
                  Icons.calendar_today,
                  'Planting Date',
                  tree.plantingDate != null
                      ? _formatDate(tree.plantingDate!)
                      : 'N/A',
                  iconColor: Colors.teal.shade600,
                ),
                _buildDivider(),
                _buildDetailRow(
                  Icons.map,
                  'Coordinates',
                  '${tree.gpsLat?.toStringAsFixed(6) ?? 'N/A'}, '
                      '${tree.gpsLng?.toStringAsFixed(6) ?? 'N/A'}',
                  iconColor: Colors.red.shade600,
                  isLast: tree.senderName == null,
                ),
                if (tree.senderName != null) ...[
                  _buildDivider(),
                  _buildDetailRow(
                    Icons.send,
                    'Sender',
                    tree.senderName.toString(),
                    iconColor: Colors.green.shade600,
                    isLast: true,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(
      IconData icon,
      String label,
      String value, {
        Color? iconColor,
        bool isLast = false,
      }) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              size: 18,
              color: Colors.green.shade700,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade500,
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1A1A2E),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Divider(
        height: 1,
        color: Colors.grey.shade200,
      ),
    );
  }


  Widget _buildImageGallery(List<String> imageUrls) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Images',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: imageUrls.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    imageUrls[index],
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 120,
                      height: 120,
                      color: Colors.grey[300],
                      child: const Icon(Icons.broken_image, color: Colors.grey),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context, TreeModel tree) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {
                  // Navigate to this tree on map
                  Navigator.pop(context);
                  openGoogleMaps(tree.gpsLat!, tree.gpsLng!);
                  // _animateCameraSafely(
                  //   CameraUpdate.newLatLngZoom(
                  //     LatLng(tree.gpsLat!, tree.gpsLng!),
                  //     16,
                  //   ),
                  // );
                },
                icon: const Icon(Icons.location_on),
                label: const Text('Open in maps'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {
                  _shareTreeDetails(tree);
                },
                icon: const Icon(Icons.share),
                label: const Text('Share'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 33),

      ],
    );
  }

  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'alive':
        return Colors.green;
      case 'dead':
        return Colors.red;
      case 'sick':
        return Colors.orange;
      case 'pending_human':
        return Colors.deepOrange;
      default:
        return Colors.grey;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  void _shareTreeDetails(TreeModel tree) {
    // Implement share functionality using share_plus package
    // Or just show a snackbar for now
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Sharing: ${tree.uniqueCode}'),
      ),
    );
  }
}