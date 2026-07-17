import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:letjordangreen/core/router/routes_names.dart';
import 'package:letjordangreen/core/utils/constants/app_colors.dart';
import 'package:letjordangreen/features/feature_buy_tree/cubits/buy_tree_cubit.dart';
import 'package:letjordangreen/features/feature_buy_tree/data/models/order_model.dart';
import 'package:letjordangreen/features/feature_projects/data/models/projects_model.dart';
import 'package:letjordangreen/widgets/custom_text_form_field.dart';

class BuyTreeScreen extends StatefulWidget {
  final ProjectsModel project;
  const BuyTreeScreen({super.key, required this.project});

  @override
  State<BuyTreeScreen> createState() => _BuyTreeScreenState();
}


class _BuyTreeScreenState extends State<BuyTreeScreen> {
  final TextEditingController _recipientNameController = TextEditingController();
  final TextEditingController _recipientEmailController = TextEditingController();
  final TextEditingController _recipientPhoneController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<BuyTreeCubit>().setProjectId(widget.project.id!);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buy a Tree'),
        backgroundColor: AppColors.scaffoldColor,
        titleSpacing: 0,
        leadingWidth: 42,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hero / Header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.green.shade700, Colors.green.shade400],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '🌳 Buy a Tree',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'You can dedicate it to yourself, or gift it to someone else — their name will appear on the certificate.',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.95),
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Order Summary Section
              _buildSectionTitle('Order Summary', Icons.receipt_long),
              const SizedBox(height: 12),

              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      _buildSummaryRow('Planting Zone', widget.project.name ?? "", Icons.public),
                      Divider(color: Colors.grey.withOpacity(.2)),
                      _buildSummaryRow('Location', widget.project.location ?? "", Icons.location_on),
                      Divider(color: Colors.grey.withOpacity(.2)),
                      _buildSummaryRow('Quantity', "1 Tree", Icons.production_quantity_limits),
                      Divider(color: Colors.grey.withOpacity(.2)),
                      _buildSummaryRow(
                        'Total',
                        '${(widget.project.clientPricePerTree).toStringAsFixed(2)} JOD',
                        Icons.attach_money,
                        isTotal: true,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Recipient Information
              _buildSectionTitle('Recipient Information', Icons.person),
              const SizedBox(height: 12),

              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      // Name Field - Required
                      CustomTextFormField(
                        labelText: "Recipient Name *",
                        textEditingController: _recipientNameController,
                        prefixIcon: const Icon(Icons.person_outline, color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey.withOpacity(.3)),
                        ),
                        style: Theme.of(context).textTheme.bodyMedium,
                        onChange: (val) {
                          context.read<BuyTreeCubit>().setName(val);

                        },
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter recipient\'s name';
                          }
                          if (value.trim().length < 2) {
                            return 'Name must be at least 2 characters';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),

                      // Email Field - Required
                      CustomTextFormField(
                        labelText: "Recipient Email *",
                        textEditingController: _recipientEmailController,
                        prefixIcon: const Icon(Icons.email_outlined, color: Colors.grey),
                        style: Theme.of(context).textTheme.bodyMedium,
                        onChange: (val) {
                          context.read<BuyTreeCubit>().setEmail(val);

                        },
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey.withOpacity(.3)),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter recipient\'s email';
                          }
                          // Simple email validation
                          final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                          if (!emailRegex.hasMatch(value.trim())) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),

                      // Phone Field - Optional
                      CustomTextFormField(
                        labelText: "Recipient Phone (optional)",
                        textEditingController: _recipientPhoneController,
                        prefixIcon: const Icon(Icons.phone_outlined, color: Colors.grey),
                        onChange: (val) {
                          context.read<BuyTreeCubit>().setPhone(val);

                        },
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey.withOpacity(.3)),
                        ),
                        style: Theme.of(context).textTheme.bodyMedium,
                        validator: (value) {
                          // Phone is optional - only validate if provided
                          if (value != null && value.trim().isNotEmpty) {
                            if (value.trim().length < 7) {
                              return 'Please enter a valid phone number';
                            }
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Features Section
              _buildSectionTitle('What\'s Included', Icons.stars),
              const SizedBox(height: 12),

              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      _buildFeatureRow(
                        Icons.verified_user,
                        'GPS-verified and photographed by a certified field farmer.',
                        Colors.green.shade700,
                      ),
                      const SizedBox(height: 16),
                      _buildFeatureRow(
                        Icons.workspace_premium,
                        'A digital certificate and tracking code delivered by email.',
                        Colors.orange.shade700,
                      ),
                      const SizedBox(height: 16),
                      _buildFeatureRow(
                        Icons.payments,
                        'No payment is taken online — our team contacts you to confirm and issue an invoice.',
                        Colors.blue.shade700,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 32),

              BlocListener<BuyTreeCubit, BuyTreeState>(
                listener: (context, state) {
                  if (state.status == Status.success) {
                    _showSuccessDialog(state.orderSuccessModel);
                  }
                },
                child: BlocBuilder<BuyTreeCubit, BuyTreeState>(
                  builder: (context, state) {
                    if (state.status == Status.loading ||
                        state.status == Status.submitting) {
                      return const SizedBox(
                        width: double.infinity,
                        height: 53,
                        child: Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              AppColors.primaryColor,
                            ),
                          ),
                        ),
                      );
                    }

                    return GestureDetector(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<BuyTreeCubit>().buyTree();
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        height: 48,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(28),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.28),
                              blurRadius: 16,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Buy This Tree 🌱',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            SizedBox(width: 8),
                            Icon(
                              Icons.arrow_forward_rounded,
                              color: Colors.white,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),

              // Disclaimer
              Center(
                child: Text(
                  'Your contribution helps reforest our planet',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: Colors.green.shade700, size: 20),
        const SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryRow(String label, String value, IconData icon, {Widget? trailing, bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 18, color: isTotal ? Colors.green.shade700 : Colors.grey.shade600),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: isTotal ? 16 : 14,
                fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
                color: isTotal ? Colors.green.shade700 : Colors.grey.shade700,
              ),
            ),
          ),
          if (trailing != null) trailing,
          if (trailing == null)
            Text(
              value,
              style: TextStyle(
                fontSize: isTotal ? 18 : 14,
                fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
                color: isTotal ? Colors.green.shade700 : Colors.grey.shade800,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildFeatureRow(IconData icon, String text, Color color) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade700,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }

  void _submitOrder() {
    // Validate the form
    if (!_formKey.currentState!.validate()) {
      // Form has errors - show a message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all required fields'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    // All validation passed - proceed with submission
    final name = _recipientNameController.text.trim();
    final email = _recipientEmailController.text.trim();
    final phone = _recipientPhoneController.text.trim();

    // Log or use the data
    print('Recipient: $name, Email: $email, Phone: ${phone.isEmpty ? "Not provided" : phone}');

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('🌳 Your tree planting request has been submitted!'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 3),
      ),
    );
  }
  void _showSuccessDialog(OrderSuccessModel? orderSuccessModel) {
    final total = widget.project.clientPricePerTree.toStringAsFixed(2);
    final recipientName = _recipientNameController.text.trim();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Success Icon with Animation
                Center(
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.green.shade600, Colors.green.shade400],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check_rounded,
                      color: Colors.white,
                      size: 48,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Thank You Message
                const Text(
                  'Thank you — your tree is on its way!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 12),

                // Description
                Text(
                  'Every tree is currently planted for the next farmer in line. $recipientName has been placed at the front of the queue and will be matched with the next tree planted — a certificate and tracking code will be emailed automatically the moment it\'s confirmed.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade700,
                    height: 1.6,
                  ),
                ),

                const SizedBox(height: 20),

                // Divider
                Container(
                  height: 1,
                  color: Colors.grey.shade200,
                ),

                const SizedBox(height: 16),

                // Order Details
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Order #${orderSuccessModel!.order!.id.toString().length > 8 ? orderSuccessModel!.order!.id.toString().substring(orderSuccessModel!.order!.id.toString().length - 8) : orderSuccessModel!.order!.id}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    Text(
                      'Total: $total JOD',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade700,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                Text(
                  'Our team will reach out by email shortly to confirm payment details and issue your invoice.',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade600,
                    height: 1.4,
                  ),
                ),

                const SizedBox(height: 24),

                // Close Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      // Optional: Navigate back or clear form
                      _clearForm();
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade700,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Done',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
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
  void _clearForm() {
    _recipientNameController.clear();
    _recipientEmailController.clear();
    _recipientPhoneController.clear();
    _formKey.currentState?.reset();
  }
}
