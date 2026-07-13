
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter/services.dart';
import 'package:letjordangreen/core/extension/capitalize_extension.dart';
import 'package:letjordangreen/core/router/routes_names.dart';
import 'package:letjordangreen/core/utils/constants/app_colors.dart';
import 'package:letjordangreen/features/feature_profile/cubits/edit_user_profile_cubit/edit_user_profile_cubit.dart';
import 'package:letjordangreen/features/feature_profile/cubits/profile_cubits/profile_cubit.dart';
import 'package:letjordangreen/features/feature_profile/widgets/image_picker_widget.dart';
import 'package:letjordangreen/features/feature_user_information/cubits/user_information_cubit/user_information_cubit.dart';
import 'package:letjordangreen/widgets/custom_text_form_field.dart';


class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final _formKey = GlobalKey<FormState>();
  final _scrollController = ScrollController();

  TextEditingController? nameTextEditingController;
  TextEditingController? lastNameTextEditingController;
  TextEditingController? phoneNumberTextEditingController;
  TextEditingController? emailTextEditingController;
  TextEditingController? birthdateTextEditingController;
  bool _isLoading = false;
  bool _hasChanges = false;
  DateTime? _selectedBirthdate;
  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().getUserProfile();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    birthdateTextEditingController?.dispose();
    nameTextEditingController?.dispose();
    lastNameTextEditingController?.dispose();
    phoneNumberTextEditingController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: _buildAppBar(),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: _LoadingAnimation());
          }
          if (state is ProfileDone) {
            return _buildEditForm(state);
          }
          if (state is ProfileFailure) {
            return _buildErrorState();
          }
          return const SizedBox();
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new, size: 18),
        onPressed: () => _handleBackPress(),
      ),
      title:  Text(
        'Edit Profile',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      actions: [
        if (_hasChanges)
          TextButton(
            onPressed: _saveChanges,
            child: const Text(
              'Save',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2563EB),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildEditForm(ProfileDone state) {
    _initializeControllers(state);

    return Form(
      key: _formKey,
      child: ListView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        children: [
        //  const SizedBox(height: 8),
        //  _buildProfileHeader(state),
         // const SizedBox(height: 16),
          _buildPersonalInfoSection(),
          const SizedBox(height: 24),
          _buildContactInfoSection(),
          const SizedBox(height: 24),
          _buildSecuritySection(),
          const SizedBox(height: 40),
          _buildSaveButton(),
          const SizedBox(height: 60),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(ProfileDone state) {
    return Center(
      child: Column(
        children: [
          // Stack(
          //   children: [
          //     Container(
          //       decoration: BoxDecoration(
          //         shape: BoxShape.circle,
          //         boxShadow: [
          //           BoxShadow(
          //             color: Colors.black.withOpacity(0.1),
          //             blurRadius: 20,
          //             offset: const Offset(0, 10),
          //           ),
          //         ],
          //       ),
          //       child: ProfessionalImagePicker(
          //         currentImageUrl: state.profile?.avatar?.url,
          //         userName: state.profile?.name,
          //       ),
          //     ),
          //     Positioned(
          //       bottom: 0,
          //       right: 0,
          //       child: Container(
          //         padding: const EdgeInsets.all(8),
          //         decoration: BoxDecoration(
          //           color: const Color(0xFF2563EB),
          //           shape: BoxShape.circle,
          //           border: Border.all(color: Colors.white, width: 3),
          //         ),
          //         child: const Icon(
          //           Icons.camera_alt,
          //           size: 20,
          //           color: Colors.white,
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
        //  const SizedBox(height: 30),
          Text(
            "${state.profile?.name?.capitalize() ?? ''} ",
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1F2937),
            ),
          ),
          // const SizedBox(height: 4),
          Text(
            state.profile?.email ?? '',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalInfoSection() {
    return _buildSectionCard(
      title: 'Personal Information',
      icon: Icons.person_outline,
      children: [
        _buildFormField(
          label: 'First Name',
          controller: nameTextEditingController!,
          hint: 'Enter your first name',
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'First name is required';
            }
            return null;
          },
          onChanged: (value) {  // ← change to accept the value
            setState(() => _hasChanges = true);
            context.read<EditUserProfileCubit>().setName(value); // ← add this
          },
        ),
        const SizedBox(height: 16),
        // _buildFormField(
        //   label: 'Last Name',
        //   controller: lastNameTextEditingController!,
        //   hint: 'Enter your last name',
        //   validator: (value) {
        //     if (value == null || value.isEmpty) {
        //       return 'Last name is required';
        //     }
        //     return null;
        //   },
        //   onChanged: (value) {
        //     setState(() => _hasChanges = true);
        //     context.read<EditUserProfileCubit>().setLastName(value); // ← add this
        //   },
        // ),
        const SizedBox(height: 16),

        _buildBirthdateField(),
      ],
    );
  }
  Widget _buildBirthdateField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Birthdate',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Colors.grey.shade700,
          ),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: _selectBirthdate,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade200),
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
            ),
            child: Row(
              children: [
                Icon(
                  Icons.cake_outlined,
                  size: 20,
                  color: Colors.grey.shade400,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    birthdateTextEditingController?.text.isEmpty ?? true
                        ? 'Select your birthdate'
                        : birthdateTextEditingController!.text,
                    style: TextStyle(
                      color: birthdateTextEditingController?.text.isEmpty ?? true
                          ? Colors.grey.shade400
                          : Colors.black87,
                      fontSize: 16,
                    ),
                  ),
                ),
                Icon(
                  Icons.calendar_today,
                  size: 18,
                  color: Colors.grey.shade400,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
  Future<void> _selectBirthdate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedBirthdate ?? DateTime.now().subtract(const Duration(days: 18 * 365)),
      firstDate: DateTime(1900),
      lastDate: DateTime.now().subtract(const Duration(days: 18 * 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF2563EB),
              onPrimary: Colors.white,
              onSurface: Color(0xFF1F2937),
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null && pickedDate != _selectedBirthdate) {
      setState(() {
        _selectedBirthdate = pickedDate.toLocal();
        birthdateTextEditingController!.text = _formatDate(pickedDate.toLocal()); // or _formatDateForDisplay
        _hasChanges = true;
      });

      context.read<EditUserProfileCubit>().setBirthdate(pickedDate);
    }
  }
  Widget _buildContactInfoSection() {
    return _buildSectionCard(
      title: 'Contact Information',
      icon: Icons.email_outlined,
      children: [
        emailTextEditingController?.text.contains("@")??false ?
        _buildFormField(
          label: 'Email Address',
          controller: emailTextEditingController!,
          hint: 'your@email.com',
          enabled: false,
          prefixIcon: Icons.email_outlined,
        ) : SizedBox(),
         SizedBox(height: emailTextEditingController?.text.contains("@")??false ? 16: 0),
        _buildFormField(
          label: 'Phone Number',
          controller: phoneNumberTextEditingController!,
          hint: '+1 234 567 8900',
          enabled: false,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey),
          keyboardType: TextInputType.phone,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Phone number is required';
            }

            return null;
          },
          prefixIcon: Icons.phone_outlined,
        ),
      ],
    );
  }

  Widget _buildSecuritySection() {
    return _buildSectionCard(
      title: 'Security',
      icon: Icons.security_outlined,
      children: [
        _buildMenuTile(
          icon: Icons.person_remove,
          title: 'Remove account',
          subtitle: 'Permanently delete your account and all data', // Added subtitle
          onTap: () {
            _showDeleteAccountDialog(); // Call dialog function
          },
        ),
        const Divider(height: 1),
      ],
    );

  }
  void _showDeleteAccountDialog() {
    showDialog(
      context: context,
      barrierDismissible: false, // User must tap a button
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.warning_amber_rounded, color: Colors.red, size: 28),
              SizedBox(width: 8),
              Text('Delete Account?'),
            ],
          ),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'This action cannot be undone.',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              Text(
                'Deleting your account will permanently remove:',
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(height: 8),
              Text(
                '• Your profile information\n'
                    '• All your data and history\n'
                    '• Saved preferences and settings\n'
                    '• Associated content and records\n'
                    'after 14 days',
                style: TextStyle(fontSize: 13),
              ),
              SizedBox(height: 12),
              Text(
                'Are you sure you want to continue?',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.red,
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
               context.read<UserInformationCubit>().logout(context);
                context.go(AppRoutes.signup);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('Delete Account'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, size: 20, color: AppColors.primaryColor),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: children,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormField({
    required String label,
    required TextEditingController controller,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
    bool enabled = true,
    String? Function(String?)? validator,
    ValueChanged<String>? onChanged,
    IconData? prefixIcon,
    TextStyle? style
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Colors.grey.shade700,
          ),
        ),
        const SizedBox(height: 8),
        CustomTextFormField(
          textEditingController: controller,
          enabled: enabled,
          textInputType: keyboardType,
          style: style?? Theme.of(context).textTheme.bodyMedium,
          onChange: (value) => onChanged?.call(value),
          validator: validator,
          prefixIcon: prefixIcon != null
              ? Icon(prefixIcon, size: 20, color: Colors.grey.shade400)
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade200),
          ),
        ),
      ],
    );
  }

  Widget _buildMenuTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    Widget? trailing,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, size: 20, color: Colors.grey.shade700),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
            ),
            trailing ?? Icon(
              Icons.chevron_right,
              size: 20,
              color: Colors.grey.shade400,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSaveButton() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      child: ElevatedButton(
        onPressed: _isLoading ? null : _saveChanges,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2563EB),
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          elevation: 0,
        ),
        child: _isLoading
            ? const SizedBox(
          height: 20,
          width: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        )
            : const Text(
          'Save Changes',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            'Failed to load profile',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Please check your connection and try again',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade500,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              context.read<ProfileCubit>().getUserProfile();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2563EB),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  void _initializeControllers(ProfileDone state) {
    if (nameTextEditingController == null) {
      nameTextEditingController = TextEditingController(text: state.profile?.name ?? '');
      // lastNameTextEditingController = TextEditingController(text: state.profile?.lastName ?? '');
      phoneNumberTextEditingController = TextEditingController(text: state.profile?.phoneNumber ?? '');
      emailTextEditingController = TextEditingController(text: state.profile?.email ?? '');

      // _selectedBirthdate = state.profile?.birthdate;

      // Format the DateTime for display
      birthdateTextEditingController = TextEditingController(
          text: _selectedBirthdate != null ? _formatDate(_selectedBirthdate!) : ''
      );

      context.read<EditUserProfileCubit>().setName(state.profile?.name ?? '');
      // context.read<EditUserProfileCubit>().setLastName(state.profile?.lastName ?? '');
      context.read<EditUserProfileCubit>().setPhoneNumber(state.profile?.phoneNumber ?? '');
      if (_selectedBirthdate != null) {
        context.read<EditUserProfileCubit>().setBirthdate(_selectedBirthdate!);
      }
    }
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
  Future<void> _saveChanges() async {
    if (!_formKey.currentState!.validate()) return;

    // Optional: Validate age
    if (_selectedBirthdate != null) {
      final age = DateTime.now().difference(_selectedBirthdate!).inDays ~/ 365;
      if (age < 18) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('You must be at least 18 years old'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
        return;
      }
    }

    setState(() => _isLoading = true);

    try {
      await context.read<EditUserProfileCubit>().updateUserProfile();
      await context.read<ProfileCubit>().getUserProfile();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profile updated successfully'),
            backgroundColor: Color(0xFF10B981),
            behavior: SnackBarBehavior.floating,
            duration: Duration(seconds: 2),
          ),
        );
        setState(() => _hasChanges = false);
        Navigator.pop(context);
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to update profile: $error'),
            backgroundColor: Colors.red.shade400,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _handleBackPress() {
    if (_hasChanges) {
      _showDiscardDialog();
    } else {
      Navigator.pop(context);
    }
  }

  void _showDiscardDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: TweenAnimationBuilder(
          tween: Tween<double>(begin: 0.8, end: 1.0),
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          builder: (context, double scale, child) {
            return Transform.scale(
              scale: scale,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Top accent bar (optional)
                    Container(
                      height: 4,
                      width: 40,
                      margin: const EdgeInsets.only(top: 16),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Icon
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.red.shade50,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.warning_amber_rounded,
                        size: 48,
                        color: Colors.red.shade400,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Title
                     Text(
                      'Discard Changes?',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),

                    const SizedBox(height: 12),

                    // Content
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        'You have unsaved changes to your profile. '
                            'Are you sure you want to discard them?',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(      color: Colors.grey.shade600,),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Action Buttons
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextButton(
                              onPressed: () => Navigator.pop(context),
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  side: BorderSide(color: Colors.grey.shade300),
                                ),
                              ),
                              child: Text(
                                'Cancel',
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(      color: Colors.grey.shade600,),

                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red.shade500,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                elevation: 0,
                              ),
                              child:  Text(
                                'Discard',
                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(      color: Colors.white,),

                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _LoadingAnimation extends StatelessWidget {
  const _LoadingAnimation();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: 40,
            height: 40,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              color: Color(0xFF2563EB),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Loading profile...',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}