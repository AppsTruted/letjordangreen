
import 'package:flutter/material.dart';
import 'package:letjordangreen/core/utils/constants/app_colors.dart';
import 'package:letjordangreen/features/feature_profile/widgets/profile_image.dart';
import 'package:shimmer/shimmer.dart';

class CustomerShimmer extends StatelessWidget {
  const CustomerShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: shimmerGreyColor,
        highlightColor: shimmerPrimaryColor,
        child:  ProfileImage(""),
    );
  }
}
final shimmerGreyColor =  Colors.grey.withOpacity(0.5);
final shimmerPrimaryColor =  AppColors.primaryColor.withOpacity(0.1);