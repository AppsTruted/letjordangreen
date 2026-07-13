import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:letjordangreen/core/router/routes_names.dart';
import 'package:letjordangreen/core/states/base_states.dart';
import 'package:letjordangreen/core/utils/constants/app_colors.dart';
import 'package:letjordangreen/features/feature_farmer_supply_orders/cubits/farmer_supply_orders_cubit.dart';
import 'package:letjordangreen/features/feature_farmer_supply_orders/data/models/supply_orders_model.dart';

class FarmerSupplyOrdersScreen extends StatefulWidget {
  const FarmerSupplyOrdersScreen({super.key});

  @override
  State<FarmerSupplyOrdersScreen> createState() =>
      _FarmerSupplyOrdersScreenState();
}

class _FarmerSupplyOrdersScreenState extends State<FarmerSupplyOrdersScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: AppBar(
        backgroundColor: AppColors.scaffoldColor,
        elevation: 0,
        title:  Text(
          'My Supply Orders',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: AppColors.primaryColor),
            onPressed: () {
              context.read<FarmerSupplyOrdersCubit>().getMyOrders();
            },
          ),
        ],
      ),
      body: BlocBuilder<FarmerSupplyOrdersCubit, BaseState<List<SupplyOrdersModel>>>(
        builder: (context, state) {
          if (state is LoadingState) {
            return const Center(
              child: LoadingWidget(
                message: 'Loading supply orders...',
              ),
            );
          } else if (state is SuccessState<List<SupplyOrdersModel>>) {
            final orders = state.data;
            if (orders.isEmpty) {
              return const EmptyStateWidget(
                icon: Icons.inventory_2_outlined,
                title: 'No Supply Orders',
                message: 'You don\'t have any supply orders assigned yet.\n'
                    'Supply orders will appear here once an admin assigns saplings to you.',
              );
            }
            return RefreshIndicator(
              onRefresh: () async {
                context.read<FarmerSupplyOrdersCubit>().getMyOrders();
              },
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final order = orders[index];
                  return SupplyOrderCard(order: order);
                },
              ),
            );
          } else if (state is ErrorState) {
            return Center(
              child: ErrorWidgetView(
                message: "Error",
                onRetry: () {
                  context.read<FarmerSupplyOrdersCubit>().getMyOrders();
                },
              ),
            );
          }
          return const SizedBox();
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.push(AppRoutes.treeScannerScreen);
        },
        backgroundColor: AppColors.primaryColor,
        icon: const Icon(Icons.qr_code_scanner, color: Colors.white),
        label: const Text(
          'Scan Tree',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class SupplyOrderCard extends StatelessWidget {
  final SupplyOrdersModel order;

  const SupplyOrderCard({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    order.projectId?.name ?? 'Unknown Project',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                StatusBadge(status: order.status ?? 'pending_supplier'),
              ],
            ),
            const SizedBox(height: 8),

            // Project Location
            if (order.projectId?.location != null) ...[
              Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    size: 16,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      order.projectId!.location!,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
            ],

            // Quantity
            Row(
              children: [
                const Icon(
                  Icons.forest,
                  size: 16,
                  color: Colors.green,
                ),
                const SizedBox(width: 4),
                Text(
                  '${order.quantity ?? 0} saplings',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Date
            Row(
              children: [
                const Icon(
                  Icons.calendar_today,
                  size: 16,
                  color: Colors.grey,
                ),
                const SizedBox(width: 4),
                Text(
                  _formatDate(order.createdAt),
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
           // const SizedBox(height: 16),

            // // Action Buttons
            // if (order.status == 'pending_supplier' || order.status == 'in_transit')
            //   SizedBox(
            //     width: double.infinity,
            //     child: ElevatedButton(
            //       onPressed: () {
            //         _showAcknowledgeDialog(context, order);
            //       },
            //       style: ElevatedButton.styleFrom(
            //         backgroundColor: AppColors.primaryColor,
            //         shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(8),
            //         ),
            //         padding: const EdgeInsets.symmetric(vertical: 12),
            //       ),
            //       child: const Text(
            //         'Acknowledge Delivery',
            //         style: TextStyle(
            //           color: Colors.white,
            //           fontWeight: FontWeight.bold,
            //         ),
            //       ),
            //     ),
            //   ),
            // if (order.status == 'delivered')
            //   SizedBox(
            //     width: double.infinity,
            //     child: OutlinedButton(
            //       onPressed: () {
            //         _showTreeInfo(context, order);
            //       },
            //       style: OutlinedButton.styleFrom(
            //         foregroundColor: Colors.green,
            //         side: const BorderSide(color: Colors.green),
            //         shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(8),
            //         ),
            //         padding: const EdgeInsets.symmetric(vertical: 12),
            //       ),
            //       child: const Text(
            //         'View Trees',
            //         style: TextStyle(
            //           fontWeight: FontWeight.bold,
            //         ),
            //       ),
            //     ),
            //   ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'N/A';
    return DateFormat('MMM dd, yyyy').format(date);
  }

  void _showAcknowledgeDialog(BuildContext context, SupplyOrdersModel order) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Acknowledge Delivery'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Project: ${order.projectId?.name ?? 'Unknown'}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text('Quantity: ${order.quantity ?? 0} saplings'),
              const SizedBox(height: 8),
              const Text(
                'By acknowledging, you confirm that you have received the saplings '
                    'and will plant them at the designated project location.',
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              //  context.read<FarmerSupplyOrdersCubit>().acknowledgeDelivery(order.id ?? '');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
              ),
              child: const Text(
                'Confirm',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showTreeInfo(BuildContext context, SupplyOrdersModel order) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Planting Information'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Trees have been delivered and acknowledged.',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.green.shade200),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.info_outline, color: Colors.green),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'You can now scan the QR codes on individual trees to '
                            'plant them in the field.',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Total trees to plant: ${order.quantity ?? 0}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
              ),
              child: const Text(
                'Got it',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}

class StatusBadge extends StatelessWidget {
  final String status;

  const StatusBadge({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Color textColor;
    String displayText;

    switch (status) {
      case 'delivered':
        backgroundColor = Colors.green.shade100;
        textColor = Colors.green.shade800;
        displayText = 'Delivered';
        break;
      case 'in_transit':
        backgroundColor = Colors.orange.shade100;
        textColor = Colors.orange.shade800;
        displayText = 'In Transit';
        break;
      case 'pending_supplier':
      default:
        backgroundColor = Colors.grey.shade200;
        textColor = Colors.grey.shade800;
        displayText = 'Pending Supplier';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        displayText,
        style: TextStyle(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

// Widgets referenced (create these if they don't exist)

class LoadingWidget extends StatelessWidget {
  final String? message;

  const LoadingWidget({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CircularProgressIndicator(
          color: AppColors.primaryColor,
        ),
        const SizedBox(height: 16),
        Text(
          message ?? 'Loading...',
          style: const TextStyle(color: Colors.grey),
        ),
      ],
    );
  }
}

class EmptyStateWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String message;

  const EmptyStateWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 80,
            color: Colors.grey.shade300,
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ErrorWidgetView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const ErrorWidgetView({
    super.key,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.error_outline,
          size: 80,
          color: Colors.red.shade300,
        ),
        const SizedBox(height: 16),
        Text(
          'Something went wrong',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ),
        const SizedBox(height: 24),
        ElevatedButton.icon(
          onPressed: onRetry,
          icon: const Icon(Icons.refresh),
          label: const Text('Retry'),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
          ),
        ),
      ],
    );
  }
}
