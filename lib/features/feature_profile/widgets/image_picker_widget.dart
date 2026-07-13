import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:letjordangreen/features/feature_profile/cubits/edit_user_profile_cubit/edit_user_profile_cubit.dart';
import 'package:letjordangreen/features/feature_scan_qr/cubits/image_picker_cubit.dart';
import 'package:letjordangreen/widgets/cached_network_image.dart';


class ProfessionalImagePicker extends StatefulWidget {
  final String? currentImageUrl;
  final String? userName;

  const ProfessionalImagePicker({
    super.key,
    this.currentImageUrl,
    this.userName,
  });

  @override
  State<ProfessionalImagePicker> createState() => _ProfessionalImagePickerState();
}

class _ProfessionalImagePickerState extends State<ProfessionalImagePicker>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _scaleAnimation = Tween<double>(begin: 0.95, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _animationController.reverse();
  }

  void _onTapUp(TapUpDetails details) {
    _animationController.forward();
  }

  void _onTapCancel() {
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final imagePickerCubit = context.watch<ImagePickerCubit>();

    return BlocBuilder<ImagePickerCubit, File?>(
      builder: (context, imageFile) {
        final bool hasImage = imageFile != null || (widget.currentImageUrl != null && widget.currentImageUrl!.isNotEmpty);

        return GestureDetector(
          onTap: () => _pickImageFromGallery(imagePickerCubit),
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Stack(
              children: [
                Container(
                  width: 110,
                  height: 110,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.shade100,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                    border: Border.all(
                      color: Colors.white,
                      width: 4,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(65),
                    child: _buildAvatarContent(imageFile, hasImage),
                  ),
                ),


                if (imageFile != null)
                  Positioned(
                    top: 6,
                    right: 6,
                    child: GestureDetector(
                      onTap: () => context.read<ImagePickerCubit>().clearImage(),
                      child: Container(
                        width: 28,
                        height: 28,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 16,
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

  Widget _buildAvatarContent(File? imageFile, bool hasImage) {
    if (imageFile != null) {
      return Image.file(
        imageFile,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      );
    } else if (hasImage) {
      return CustomCachedNetworkImageView(
        imageUrl: widget.currentImageUrl!,
        boxFit: BoxFit.cover,
      );
    } else {
      return _buildPlaceholder();
    }
  }

  Widget _buildPlaceholder() {
    return Container(
      color: Colors.grey.shade200,
      child: Center(
        child: widget.userName != null && widget.userName!.isNotEmpty
            ? Text(
          widget.userName![0].toUpperCase(),
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade500,
          ),
        )
            : Icon(
          Icons.person,
          size: 50,
          color: Colors.grey.shade400,
        ),
      ),
    );
  }

  Future<void> _pickImageFromGallery(ImagePickerCubit imagePickerCubit) async {
    try {

      final pickedFile = await imagePickerCubit.pickImageFromGallery();
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );

      // Upload image
      final imageUrl = await imagePickerCubit.uploadImage(File(pickedFile.path));

      // Close loading indicator
      Navigator.pop(context);

      // Update profile
      context.read<EditUserProfileCubit>().setProfileImage(imageUrl);

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profile image updated successfully'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      // Close loading indicator if open
      Navigator.pop(context);

      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to upload image: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}