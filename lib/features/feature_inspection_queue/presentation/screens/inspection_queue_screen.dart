import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:letjordangreen/core/states/base_states.dart';
import 'package:letjordangreen/core/utils/constants/app_colors.dart';
import 'package:letjordangreen/features/feature_inspection_queue/cubits/inspection_queue_cubit.dart';
import 'package:letjordangreen/features/feature_inspection_queue/data/models/inspection_queue_model.dart';
import 'package:letjordangreen/widgets/custom_text_form_field.dart';

class InspectionQueueScreen extends StatefulWidget {
  const InspectionQueueScreen({super.key});

  @override
  State<InspectionQueueScreen> createState() => _InspectionQueueScreenState();
}

class _InspectionQueueScreenState extends State<InspectionQueueScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _selectedFilter = 'all';
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _loadData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _loadData() {
    context.read<InspectionQueueCubit>().getRestaurantOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildFilterTabs(),
          Expanded(
            child: BlocConsumer<InspectionQueueCubit, BaseState<InspectionQueueModel>>(
              listener: (context, state) {
                if (state is ErrorState) {
                  _showErrorSnackBar(context);
                }
              },
              builder: (context, state) {
                if (state is LoadingState) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is SuccessState<InspectionQueueModel>) {
                  final orders = state.data.docs ?? [];
                  final filteredOrders = _filterOrders(orders);

                  if (filteredOrders.isEmpty) {
                    return _buildEmptyState();
                  }

                  return RefreshIndicator(
                    onRefresh: _refreshData,
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16),
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: filteredOrders.length,
                      itemBuilder: (context, index) {
                        final order = filteredOrders[index];
                        return _buildOrderCard(context, order);
                      },
                    ),
                  );
                } else if (state is InitialState) {
                  return _buildInitialState();
                } else {
                  return _buildErrorState();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.scaffoldColor,
      elevation: 0,
      titleSpacing: 0,
      title:  Text(
        "Inspection Queue",
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      actions: [
        IconButton(
          onPressed: _refreshData,
          icon: const Icon(Icons.refresh, color: Colors.black54),
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: Container(
          height: 1,
          color: Colors.grey.shade200,
        ),
      ),
    );
  }


  Widget _buildFilterTabs() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(bottom: 8),
      child: TabBar(
        controller: _tabController,
        labelColor: Colors.black87,
        unselectedLabelColor: Colors.grey.shade600,
        indicatorColor: AppColors.primaryColor,
        labelStyle: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
        tabs: const [
          Tab(text: 'All'),
          Tab(text: 'Pending'),
          Tab(text: 'Approved'),
          Tab(text: 'Rejected'),
        ],
        onTap: (index) {
          setState(() {
            switch (index) {
              case 0:
                _selectedFilter = 'all';
                break;
              case 1:
                _selectedFilter = 'pending_human';
                break;
              case 2:
                _selectedFilter = 'approved';
                break;
              case 3:
                _selectedFilter = 'rejected';
                break;
            }
          });
        },
      ),
    );
  }

  Widget _buildOrderCard(BuildContext context, Doc order) {
    final isPending = order.verificationStatus == 'pending_human';
    final isRejected = order.verificationStatus == 'rejected';
    final statusColor = isPending ? Colors.orange : (isRejected ? Colors.red : Colors.green);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _showOrderDetails(context, order),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: statusColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: statusColor),
                          ),
                          child: Text(
                            _getStatusText(order.verificationStatus),
                            style: TextStyle(
                              color: statusColor,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: _getPriorityColor(order).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: _getPriorityColor(order)),
                          ),
                          child: Text(
                            'URGENT',
                            style: TextStyle(
                              color: _getPriorityColor(order),
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Order ID and name
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        order.uniqueCode?.substring(0, 2).toUpperCase() ?? 'OT',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          order.ownerName ?? 'Unknown Owner',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          'ID: ${order.uniqueCode ?? 'N/A'}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              // Details grid
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Wrap(
                  spacing: 12,
                  runSpacing: 8,
                  children: [
                    _buildDetailChip(
                      icon: Icons.person_outline,
                      label: order.farmerId?.name ?? 'N/A',
                    ),
                    _buildDetailChip(
                      icon: Icons.phone_outlined,
                      label: order.ownerPhone ?? 'N/A',
                    ),
                    _buildDetailChip(
                      icon: Icons.business_outlined,
                      label: order.projectId?.name ?? 'N/A',
                    ),
                    _buildDetailChip(
                      icon: Icons.image_outlined,
                      label: '${order.imageUrls?.length ?? 0} images',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // Footer with date and actions
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    DateFormat('MMM dd, yyyy • hh:mm a').format(
                        order.createdAt ?? DateTime.now()
                    ),
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey.shade500,
                    ),
                  ),
                  Row(
                    children: [
                      if (isPending) ...[
                        _buildActionButton(
                          icon: Icons.check_circle_outline,
                          label: 'Approve',
                          color: Colors.green,
                          onTap: () => _updateOrderStatus(order.id!, 'approved'),
                        ),
                        const SizedBox(width: 8),
                        _buildActionButton(
                          icon: Icons.cancel_outlined,
                          label: 'Reject',
                          color: Colors.red,
                          onTap: () => _showRejectDialog(context, order),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailChip({required IconData icon, required String label}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: Colors.grey.shade600),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Row(
          children: [
            Icon(icon, size: 16, color: color),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inbox_outlined,
            size: 80,
            color: Colors.grey.shade300,
          ),
          const SizedBox(height: 16),
          Text(
            'No orders found',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Pull down to refresh or adjust filters',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade500,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: _refreshData,
            icon: const Icon(Icons.refresh),
            label: const Text('Refresh'),
          ),
        ],
      ),
    );
  }

  Widget _buildInitialState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.storefront_outlined,
            size: 80,
            color: Colors.grey.shade300,
          ),
          const SizedBox(height: 16),
          Text(
            'No orders loaded',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tap refresh to load orders',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade500,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: _loadData,
            icon: const Icon(Icons.refresh),
            label: const Text('Load Orders'),
          ),
        ],
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
            size: 80,
            color: Colors.red.shade300,
          ),
          const SizedBox(height: 16),
          Text(
            'Failed to load orders',
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
          ElevatedButton.icon(
            onPressed: _refreshData,
            icon: const Icon(Icons.refresh),
            label: const Text('Retry'),
          ),
        ],
      ),
    );
  }



  // Helper methods
  List<Doc> _filterOrders(List<Doc> orders) {
    List<Doc> filtered = List.from(orders);

    // Apply status filter
    if (_selectedFilter != 'all') {
      filtered = filtered.where((order) {
        return order.verificationStatus == _selectedFilter;
      }).toList();
    }

    // Apply search filter
    if (_searchController.text.isNotEmpty) {
      final query = _searchController.text.toLowerCase();
      filtered = filtered.where((order) {
        return (order.ownerName?.toLowerCase().contains(query) ?? false) ||
            (order.uniqueCode?.toLowerCase().contains(query) ?? false) ||
            (order.ownerPhone?.contains(query) ?? false) ||
            (order.farmerId?.name?.toLowerCase().contains(query) ?? false);
      }).toList();
    }

    return filtered;
  }

  String _getStatusText(String? status) {
    switch (status) {
      case 'pending_human':
        return 'Pending Review';
      case 'approved':
        return 'Approved';
      case 'rejected':
        return 'Rejected';
      default:
        return status ?? 'Unknown';
    }
  }

  Color _getPriorityColor(Doc order) {
    // Add logic for priority based on criteria
    if (order.rejectionCount != null && order.rejectionCount! > 0) {
      return Colors.red;
    }
    if (order.createdAt != null) {
      final hours = DateTime.now().difference(order.createdAt!).inHours;
      if (hours > 48) return Colors.orange;
      if (hours > 24) return Colors.amber;
    }
    return Colors.blue;
  }

  // Actions
  Future<void> _refreshData() async {
    await context.read<InspectionQueueCubit>().getRestaurantOrders();
  }

  void _updateOrderStatus(String orderId, String status) {
    context.read<InspectionQueueCubit>().updateOrderLocally(
      orderId,
      {'verificationStatus': status},
    );
    context.read<InspectionQueueCubit>().updateStatus(
      status, orderId

    );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Order ${status == 'approved' ? 'approved' : 'rejected'} successfully'),
        backgroundColor: status == 'approved' ? Colors.green : Colors.red,
      ),
    );
  }

  void _showEditDialog(BuildContext context, Doc order) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Order'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Owner Name',
                border: OutlineInputBorder(),
              ),
              controller: TextEditingController(text: order.ownerName),
            ),
            const SizedBox(height: 12),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
              ),
              controller: TextEditingController(text: order.ownerPhone),
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
              // Update logic here
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Order updated locally')),
              );
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  void _showRejectDialog(BuildContext context, Doc order) {
    final reasonController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reject Order'),
        insetPadding: EdgeInsets.all(12),
         shape: OutlineInputBorder( borderRadius: BorderRadius.circular(8)),
        content: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Please provide a reason for rejection:'),
              const SizedBox(height: 12),
              CustomTextFormField(
                textEditingController: reasonController,
                hintText: 'Enter rejection reason',
                border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                maxLine: 3,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (reasonController.text.isNotEmpty) {
                final rejectionCount = (order.rejectionCount ?? 0) + 1;
                context.read<InspectionQueueCubit>().updateOrderLocally(
                  order.id!,
                  {
                    'verificationStatus': 'rejected',
                    'rejectionReason': reasonController.text,
                    'rejectionCount': rejectionCount,
                  },
                );
                context.read<InspectionQueueCubit>().updateStatus(
                  "rejected",
                  order.id!,
                );
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Order rejected')),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please enter a reason')),
                );
              }
            },
            child: const Text('Reject'),
          ),
        ],
      ),
    );
  }

  void _showOrderDetails(BuildContext context, Doc order) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.9,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (context, scrollController) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView(
                  controller: scrollController,
                  children: [
                    Text(
                      'Order Details',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildDetailItem('Order ID', order.uniqueCode ?? 'N/A'),
                    _buildDetailItem('Owner Name', order.ownerName ?? 'N/A'),
                    _buildDetailItem('Email', order.ownerEmail ?? 'N/A'),
                    _buildDetailItem('Phone', order.ownerPhone ?? 'N/A'),
                    _buildDetailItem('Farmer', order.farmerId?.name ?? 'N/A'),
                    _buildDetailItem('Project', order.projectId?.name ?? 'N/A'),
                    _buildDetailItem('Status', _getStatusText(order.verificationStatus)),
                    _buildDetailItem('Created',
                        DateFormat('MMM dd, yyyy hh:mm a').format(order.createdAt ?? DateTime.now())
                    ),
                    _buildDetailItem('Images', '${order.imageUrls?.length ?? 0} images'),
                    if (order.rejectionReason != null) ...[
                      _buildDetailItem('Rejection Reason', order.rejectionReason.toString()),
                    ],
                    const SizedBox(height: 20),
                    if (order.imageUrls != null && order.imageUrls!.isNotEmpty) ...[
                      const Text(
                        'Images',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 120,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: order.imageUrls!.length,
                          itemBuilder: (context, index) {
                            return Container(
                              width: 120,
                              margin: const EdgeInsets.only(right: 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.grey.shade200,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  order.imageUrls![index],
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Center(
                                      child: Icon(Icons.broken_image, size: 40),
                                    );
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterDialog() {
    // Implement filter dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Filter Orders'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('All'),
              leading: Radio<String>(
                value: 'all',
                groupValue: _selectedFilter,
                onChanged: (value) {
                  setState(() => _selectedFilter = value!);
                  Navigator.pop(context);
                },
              ),
            ),
            ListTile(
              title: const Text('Pending Review'),
              leading: Radio<String>(
                value: 'pending_human',
                groupValue: _selectedFilter,
                onChanged: (value) {
                  setState(() => _selectedFilter = value!);
                  Navigator.pop(context);
                },
              ),
            ),
            ListTile(
              title: const Text('Approved'),
              leading: Radio<String>(
                value: 'approved',
                groupValue: _selectedFilter,
                onChanged: (value) {
                  setState(() => _selectedFilter = value!);
                  Navigator.pop(context);
                },
              ),
            ),
            ListTile(
              title: const Text('Rejected'),
              leading: Radio<String>(
                value: 'rejected',
                groupValue: _selectedFilter,
                onChanged: (value) {
                  setState(() => _selectedFilter = value!);
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showErrorSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Failed to load orders. Please try again.'),
        backgroundColor: Colors.red.shade700,
        action: SnackBarAction(
          label: 'Retry',
          textColor: Colors.white,
          onPressed: _refreshData,
        ),
      ),
    );
  }
}