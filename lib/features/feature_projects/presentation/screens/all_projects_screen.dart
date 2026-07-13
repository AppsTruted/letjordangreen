import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:letjordangreen/core/hive/user.dart';
import 'package:letjordangreen/core/router/routes_names.dart';
import 'package:letjordangreen/core/states/base_states.dart';
import 'package:letjordangreen/core/utils/constants/app_colors.dart';
import 'package:letjordangreen/features/feature_home/data/models/projects_model.dart';
import 'package:letjordangreen/features/feature_projects/cubits/projects_cubit.dart';
import 'package:letjordangreen/features/feature_scan_qr/cubits/scan_qr_cubit/scan_qr_cubit.dart';
import 'package:letjordangreen/features/feature_user_information/cubits/user_information_cubit/user_information_cubit.dart';

class AllProjectsScreen extends StatefulWidget {
  const AllProjectsScreen({super.key});

  @override
  State<AllProjectsScreen> createState() => _AllProjectsScreenState();
}

class _AllProjectsScreenState extends State<AllProjectsScreen> {
  UserInformationCubit userInformationCubit = UserInformationCubit();
  late UserHiveModel userHiveModel;
  @override
  void initState() {
    super.initState();
    userHiveModel = userInformationCubit.state.userHiveModel;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: AppBar(
        backgroundColor: AppColors.scaffoldColor,
        elevation: 0,
        titleSpacing: 0,
        title:  Text(
          'All Projects',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
      body: BlocBuilder<ProjectsCubit, BaseState<List<ProjectsModel>>>(
        builder: (context, state) {
          if (state is LoadingState<List<ProjectsModel>>) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
              ),
            );
          }

          if (state is SuccessState<List<ProjectsModel>>) {
            final projects = state.data;

            if (projects.isEmpty) {
              return _buildEmptyState();
            }

            return RefreshIndicator(
              onRefresh: () async {
                context.read<ProjectsCubit>().getProjects();
              },
              color: AppColors.primaryColor,
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                itemCount: projects.length,
                itemBuilder: (context, index) {
                  final project = projects[index];
                  return _ProjectCard(project: project);
                },
              ),
            );
          }

          if (state is ErrorState<List<ProjectsModel>>) {
            return _buildErrorState(state.message ?? 'Failed to load projects');
          }

          // Initial state - load projects
          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.folder_open_outlined,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No Projects Found',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tap the + button to create your first project',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: () {
              // Navigate to create project
            },
            icon: const Icon(Icons.add),
            label: const Text('Create Project'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red[300],
            ),
            const SizedBox(height: 16),
            Text(
              'Something went wrong',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[500],
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                context.read<ProjectsCubit>().getProjects();
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Try Again'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Project Card Widget - Professional Version
class _ProjectCard extends StatelessWidget {
  final ProjectsModel project;
  UserInformationCubit userInformationCubit = UserInformationCubit();
  late UserHiveModel userHiveModel;

   _ProjectCard({required this.project});

  @override
  Widget build(BuildContext context) {
    userHiveModel = userInformationCubit.state.userHiveModel;

    return GestureDetector(
      onTap: () {

      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Project Header with Status
            Row(
              children: [
                // Project Avatar/Icon
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.forest_rounded,
                    color: AppColors.primaryColor,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        project.name ?? 'Unnamed Project',
                        style: Theme.of(context).textTheme.bodyLarge,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            size: 14,
                            color: Colors.grey[500],
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              project.location ?? 'No location',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey[500],
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Status Badge
                _buildStatusBadge(project),
              ],
            ),

            const SizedBox(height: 16),

            // Progress Section
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Completion Progress',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[600],
                      ),
                    ),
                    Text(
                      _calculateProgress(project),
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: _calculateProgressValue(project),
                    backgroundColor: Colors.grey[100],
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      AppColors.primaryColor,
                    ),
                    minHeight: 8,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Financial Summary
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.scaffoldColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _FinancialItem(
                    label: 'Client Price',
                    value: '${project.clientPricePerTree?.toStringAsFixed(2) ?? '0.00'}',
                  ),
                  Container(
                    width: 1,
                    height: 24,
                    color: Colors.grey[300],
                  ),
                  _FinancialItem(
                    label: 'Farmer Payout',
                    value: '${project.farmerPayoutPerTree?.toStringAsFixed(2) ?? '0.00'}',
                  ),
                  Container(
                    width: 1,
                    height: 24,
                    color: Colors.grey[300],
                  ),
                  _FinancialItem(
                    label: 'Trees',
                    value: '${project.plantedTreesCount ?? 0}/${project.maxCapacity ?? 0}',
                  ),
                ],
              ),
            ),
            if( userHiveModel.roles?.contains('farmer')??false)
            const SizedBox(height: 16),

            // Plant Tree Button
           if( userHiveModel.roles?.contains('farmer')??false)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  context.read<ScanQrCubit>().setProjectId(project.id!);
                  context.push(AppRoutes.treeScannerScreen);
                },
                icon: const Icon(Icons.grass_rounded, size: 20),
                label: const Text(
                  'Plant Tree',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(ProjectsModel project) {
    final progress = _calculateProgressValue(project);
    String status;
    Color color;

    if (progress >= 1.0) {
      status = 'Completed';
      color = const Color(0xff10b981); // Green
    } else if (progress >= 0.5) {
      status = 'In Progress';
      color = const Color(0xfff59e0b); // Amber
    } else {
      status = 'Pending';
      color = const Color(0xff6b7280); // Gray
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            status,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  String _calculateProgress(ProjectsModel project) {
    final planted = project.plantedTreesCount ?? 0;
    final capacity = project.maxCapacity ?? 0;

    if (capacity == 0) return '0%';
    final percentage = (planted / capacity * 100).clamp(0.0, 100.0);
    return '${percentage.round()}%';
  }

  double _calculateProgressValue(ProjectsModel project) {
    final planted = project.plantedTreesCount ?? 0;
    final capacity = project.maxCapacity ?? 0;

    if (capacity == 0) return 0.0;
    return (planted / capacity).clamp(0.0, 1.0);
  }
}

// Financial Item Widget
class _FinancialItem extends StatelessWidget {
  final String label;
  final String value;

  const _FinancialItem({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: Colors.grey[500],
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

