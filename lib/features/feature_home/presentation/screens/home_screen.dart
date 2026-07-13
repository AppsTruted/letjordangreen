import 'dart:developer';

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

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const Color darkGreen = Color(0xff003f21);
  static const Color cardGreen = Color(0xff195832);
  static const Color softCream = Color(0xfffbf5ea);
  static const Color paleCream = Color(0xfff6edd8);
  static const Color textDark = Color(0xff07160b);
  static const Color mutedGreen = Color(0xff55715b);
  static const Color brown = Color(0xff6b3b0f);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserInformationCubit userInformationCubit = UserInformationCubit();
  late UserHiveModel userHiveModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userHiveModel = userInformationCubit.state.userHiveModel;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HomeScreen.softCream,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(bottom: 34),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),


              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Welcome back to jordan green',
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.65),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              const SizedBox(height: 6),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Your Growing Legacy',
                  style: TextStyle(
                    color: HomeScreen.darkGreen,
                    fontSize: 27,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.7,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: _ContributionCard(),
              ),

              const SizedBox(height: 22),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children:  [
                    Expanded(
                      child: _ActionBox(
                        icon: Icons.add_box_outlined,
                        label: 'Plant a Tree',
                        color: HomeScreen.darkGreen,
                        onTap: !userHiveModel.roles!.contains('farmer') ?
                        ()=> _showNotFarmerDialog(context):
                            ()=> context.push(AppRoutes.treeScannerScreen),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: _ActionBox(
                        icon: Icons.location_on_outlined,
                        label: 'Track Tree',
                        onTap: ()=> context.push(AppRoutes.mapScreen),
                        color: HomeScreen.mutedGreen,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 22),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _SectionTitle(
                  title: 'Active Projects',
                  action: 'View All',
                  onActionTap: ()=> context.push(AppRoutes.allProjectsScreen),
                ),
              ),

              const SizedBox(height: 16),

              BlocBuilder<ProjectsCubit, BaseState<List<ProjectsModel>>>(
                builder: (context, state) {
                  if (state is SuccessState<List<ProjectsModel>>) {
                    return SizedBox(
                      height: 250,
                      child: ListView.separated(
                        separatorBuilder: (context, index) => const SizedBox(width: 8),
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.only(left: 12, right: 12),
                        itemCount: state.data.length,
                        itemBuilder: (context, index) {
                          final project = state.data[index];

                          // Calculate progress percentage
                          double progressValue = project.maxCapacity > 0
                              ? project.plantedTreesCount / project.maxCapacity
                              : 0.0;
                          String percent = '${(progressValue * 100).toStringAsFixed(0)}%';

                          return _ForestCard(
                            image: 'assets/img/background-splash.jpg',
                            badge: 'ACTIVE',
                            title: project.name ?? "",
                            subtitle: project.location ?? "",
                            progressLabel: 'Planting Progress',
                            percent: percent,
                            progress: progressValue,
                            badgeColor: const Color(0xffd8f0d4),
                            badgeTextColor: const Color(0xff39754c),
                            assignedTrees: project.assignedTreesCount,
                            plantedTrees: project.plantedTreesCount,
                            maxCapacity: project.maxCapacity,
                            clientPrice: project.clientPricePerTree,
                            farmerPayout: project.farmerPayoutPerTree,
                            project: project
                          );
                        },
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),

              const SizedBox(height: 16),


               Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Community & News',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: HomeScreen.darkGreen, fontSize: 16),
                ),
              ),

              const SizedBox(height: 16),

               Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    _NewsCard(
                      image: 'assets/img/background-login.jpg',
                      category: 'MILESTONE',
                      title: "Jordan's Reforestation\nMilestone Reached",
                      body: '2.5M trees recorded across the\nplateau...',
                      onTap: () => _showNewsDetails(context),
                    ),
                    SizedBox(height: 14),
                    _NewsCard(
                      image: 'assets/img/background-login.jpg',
                      category: 'EXPERT TIP',
                      title: 'Sustainability Tip: Choosing\nNative Species',
                      body: 'Why local flora supports\nbiodiversity better...',
                      onTap: () => _showNewsDetails(context),

                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void _showNewsDetails(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
                child: Image.asset(
                  'assets/img/background-login.jpg',
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

              // Content
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Category
                    Text(
                      'MILESTONE',
                      style: TextStyle(
                        color: HomeScreen.mutedGreen,
                        fontSize: 12,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.7,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Title
                    Text(
                      "Jordan's Reforestation Milestone Reached",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: HomeScreen.textDark,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Body
                    const Text(
                      '2.5 million trees have been successfully recorded across the Jordanian plateau as part of the National Reforestation Initiative. This milestone represents a 40% increase in forest coverage since the project began in 2020.',
                      style: TextStyle(
                        fontSize: 15,
                        height: 1.5,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Date/Stats
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          size: 16,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'July 13, 2026',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(width: 20),
                        Icon(
                          Icons.forest,
                          size: 16,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '2.5M trees',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Close button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Close',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              SizedBox(height: 50,)
            ],
          ),
        );
      },
    );
  }
  void _showNotFarmerDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Access Restricted'),
          content: const Text(
            'Only farmers can plant trees. '
                'Please register as a farmer to access this feature.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}


class _ContributionCard extends StatelessWidget {
  const _ContributionCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 228,
      decoration: BoxDecoration(
        color: HomeScreen.cardGreen,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.14),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -18,
            bottom: 6,
            child: Container(
              width: 112,
              height: 112,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.12),
                shape: BoxShape.circle,
              ),
            ),
          ),

          Positioned(
            right: 20,
            top: 24,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.12),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                'Level 12',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.78),
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(23, 23, 23, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'OVERALL CONTRIBUTION',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.82),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.3,
                  ),
                ),
                const SizedBox(height: 7),
                const Text(
                  'Small seeds, mighty forests',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.3,
                  ),
                ),
                const Spacer(),
                Row(
                  children: const [
                    Expanded(
                      child: _StatBox(
                        icon: Icons.park_outlined,
                        number: '124',
                        label: 'Trees Planted',
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: _StatBox(
                        customLabel: 'CO₂',
                        number: '3.2',
                        label: 'Tons CO2 Offset',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatBox extends StatelessWidget {
  final IconData? icon;
  final String? customLabel;
  final String number;
  final String label;

  const _StatBox({
    this.icon,
    this.customLabel,
    required this.number,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 109,
      padding: const EdgeInsets.fromLTRB(15, 15, 12, 13),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.12),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.white.withOpacity(0.10),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null)
            Icon(
              icon,
              color: Colors.white.withOpacity(0.58),
              size: 23,
            )
          else
            Text(
              customLabel ?? '',
              style: TextStyle(
                color: Colors.white.withOpacity(0.55),
                fontSize: 11,
                fontWeight: FontWeight.w900,
                letterSpacing: 1,
              ),
            ),
          const Spacer(),
          Text(
            number,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w900,
              height: 1,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.68),
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionBox extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback? onTap;

  const _ActionBox({
    required this.icon,
    required this.label,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 103,
        decoration: BoxDecoration(
          color: HomeScreen.paleCream,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: color.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 22,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              label,
              style: const TextStyle(
                color: HomeScreen.textDark,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  final String action;
  final VoidCallback? onActionTap;

  const _SectionTitle({
    required this.title,
    required this.action,
    this.onActionTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: HomeScreen.darkGreen,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        GestureDetector(
          onTap: onActionTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xffece9dd),
              borderRadius: BorderRadius.circular(22),
            ),
            child: Text(
              action,
              style: const TextStyle(
                color: Color(0xffa8d6aa),
                fontSize: 13,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ForestCard extends StatelessWidget {
  final String image;
  final String badge;
  final String title;
  final String subtitle;
  final String progressLabel;
  final String percent;
  final double progress;
  final Color badgeColor;
  final Color badgeTextColor;

  // New fields for the project data
  final int assignedTrees;
  final int plantedTrees;
  final int maxCapacity;
  final double clientPrice;
  final double farmerPayout;
  ProjectsModel project;

   _ForestCard({
    required this.image,
    required this.badge,
    required this.title,
    required this.subtitle,
    required this.progressLabel,
    required this.percent,
    required this.progress,
    required this.badgeColor,
    required this.badgeTextColor,
    required this.assignedTrees,
    required this.plantedTrees,
    required this.maxCapacity,
    required this.clientPrice,
    required this.farmerPayout, required this.project,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        context.read<ScanQrCubit>().setProjectId(project.id!);
        context.push(AppRoutes.treeScannerScreen);
      },
      child: Container(
        width: 300,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(17),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.asset(
                  image,
                  width: double.infinity,
                  height: 140,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 14,
                  left: 13,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 11, vertical: 6),
                    decoration: BoxDecoration(
                      color: badgeColor,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Row(
                      spacing: 6,
                      children: [
                        Icon(Icons.forest, color: Colors.green.shade900,size: 14,),

                        Text(
                          "Max: ${project.maxCapacity.toString()} tree",
                          style: TextStyle(
                            color: badgeTextColor,
                            fontSize: 11,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(17, 12, 17, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: HomeScreen.textDark,
                      fontSize: 17,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 2),

                  // Location
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.62),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // // Tree Statistics Row
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     _buildStatItem(
                  //       label: 'Assigned',
                  //       value: assignedTrees.toString(),
                  //       color: HomeScreen.mutedGreen,
                  //     ),
                  //     _buildStatItem(
                  //       label: 'Planted',
                  //       value: plantedTrees.toString(),
                  //       color: const Color(0xff39754c),
                  //     ),
                  //     _buildStatItem(
                  //       label: 'Capacity',
                  //       value: maxCapacity.toString(),
                  //       color: Colors.grey.shade600,
                  //     ),
                  //   ],
                  // ),
                  // const SizedBox(height: 12),
                  //
                  // // Financial Info Row
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     _buildPriceItem(
                  //       label: 'Client Price',
                  //       value: '\$${clientPrice.toStringAsFixed(0)}',
                  //     ),
                  //     _buildPriceItem(
                  //       label: 'Farmer Payout',
                  //       value: '\$${farmerPayout.toStringAsFixed(1)}',
                  //     ),
                  //   ],
                  // ),
                  // const SizedBox(height: 12),

                  // Progress Row
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          progressLabel,
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.72),
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Text(
                        percent,
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.72),
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),

                  // Progress Bar
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 5,
                      backgroundColor: const Color(0xfff0ead6),
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        HomeScreen.mutedGreen,
                      ),
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

  Widget _buildStatItem({
    required String label,
    required String value,
    required Color color,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w800,
            color: color,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 9,
            fontWeight: FontWeight.w600,
            color: Colors.black.withOpacity(0.5),
          ),
        ),
      ],
    );
  }

  Widget _buildPriceItem({
    required String label,
    required String value,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: Color(0xff2d4a33),
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 9,
            fontWeight: FontWeight.w600,
            color: Colors.black.withOpacity(0.5),
          ),
        ),
      ],
    );
  }

}

class _NewsCard extends StatelessWidget {
  final String image;
  final String category;
  final String title;
  final String body;
  final VoidCallback? onTap;  // Add this

  const _NewsCard({
    required this.image,
    required this.category,
    required this.title,
    required this.body,
    this.onTap,  // Add this
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(  // Wrap with GestureDetector
      onTap: onTap,  // Add this
      child: Container(
        height: 121,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(17),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.035),
              blurRadius: 14,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(11),
              child: Image.asset(
                image,
                width: 92,
                height: 92,
                errorBuilder: (context, error, stackTrace) => SizedBox(
                  width: 92,
                  height: 92,
                ),
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      category,
                      style: const TextStyle(
                        color: HomeScreen.mutedGreen,
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.7,
                      ),
                    ),
                    const SizedBox(height: 9),
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: HomeScreen.textDark,
                        fontSize: 13,
                        fontWeight: FontWeight.w900,
                        height: 1.06,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      body,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.65),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        height: 1.05,
                      ),
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
}