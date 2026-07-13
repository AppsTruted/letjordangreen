// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:go_router/go_router.dart';
// import 'package:loyalitytech/core/extension/capitalize_extension.dart';
// import 'package:loyalitytech/core/functions/helpers.dart';
// import 'package:loyalitytech/core/hive/user.dart';
// import 'package:loyalitytech/core/router/routes_names.dart';
// import 'package:loyalitytech/core/utils/constants/app_colors.dart';
// import 'package:loyalitytech/features/feature_auth/feature_check_token/cubit/check_token_cubit.dart';
// import 'package:loyalitytech/features/feature_profile/cubits/profile_cubits/profile_cubit.dart';
// import 'package:loyalitytech/features/feature_user_information/cubits/user_information_cubit/user_information_cubit.dart';
//
//
// class AccountSettingsScreen extends StatefulWidget {
//   const AccountSettingsScreen({super.key});
//
//   @override
//   State<AccountSettingsScreen> createState() => _AccountSettingsScreenState();
// }
//
//
// class _AccountSettingsScreenState extends State<AccountSettingsScreen> {
//   UserInformationCubit userInformationCubit = UserInformationCubit();
//   late UserHiveModel userHiveModel;
//
//   @override
//   void initState() {
//     super.initState();
//     userHiveModel = userInformationCubit.state.userHiveModel;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: const BackButton(),
//         backgroundColor: AppColors.greyScaffoldColor,
//         leadingWidth: 40,
//         titleSpacing: 0,
//         title: Text(
//           'Account Settings',
//           style: Theme.of(context).textTheme.bodyLarge,
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: BlocBuilder<ProfileCubit, ProfileState>(
//           builder: (context, state) {
//             if (state is ProfileDone) {
//               return Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     spacing: 4,
//                     children: [
//                       // Avatar with conditional display
//                       _buildAvatar(state),
//                       Container(
//                         padding: const EdgeInsets.all(12.0),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(8.0),
//                         ),
//                         child: Column(
//                           spacing: 2,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               "${(state.profile?.firstName?.isNotEmpty == true ? state.profile?.firstName?.capitalize() : state.profile?.username)} ${(state.profile?.lastName?.isNotEmpty == true ? state.profile?.lastName : "")}",
//                               style: Theme.of(context).textTheme.bodyLarge,
//                             ),
//                             Text(
//                               userHiveModel.username ?? "",
//                               style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black54),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Spacer(),
//                       IconButton(onPressed: (){
//                         context.push(AppRoutes.editProfileScreen);
//
//                       }, icon: SvgPicture.asset('assets/svg/editing.svg', color: Colors.grey.shade500,height: 20,))
//                     ],
//                   ),
//                   const SizedBox(height: 16),
//
//                   Text(
//                     'Accounts Details',
//                     style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 13, color: Colors.grey.shade600),
//                   ),
//                   const SizedBox(height: 16),
//
//                   Container(
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     padding: const EdgeInsets.all(12),
//                     child: Column(
//                       spacing: 4,
//                       children: [
//                         _buildDetailRow('Full Name', "${(state.profile?.firstName?.isNotEmpty == true ? state.profile?.firstName?.capitalize() : state.profile?.username)} ${(state.profile?.lastName?.isNotEmpty == true ? state.profile?.lastName : "---------")}", context),
//                         _buildDetailRow('Username', userHiveModel.username ?? "", context),
//                         BlocBuilder<CheckTokenCubit, CheckTokenState>(
//                           builder: (context, state) {
//                             if (state is CheckTokenDone) {
//                               return _buildDetailRow('Balance', toComma(state.checkToken.user?.totalBalance.toString() ?? ""), context);
//                             }
//                             return const SizedBox();
//                           },
//                         ),
//
//                       ],
//                     ),
//                   ),
//                 ],
//               );
//             }
//             return const SizedBox();
//           },
//         ),
//       ),
//     );
//   }
//
//   Widget _buildAvatar(ProfileDone state) {
//     final avatarUrl = state.profile?.avatar?.url;
//     final hasAvatar = avatarUrl != null && avatarUrl.isNotEmpty;
//
//     return CircleAvatar(
//       radius: 30,
//       backgroundColor: AppColors.primaryColor,
//       child: ClipOval(
//         child: hasAvatar
//             ? CachedNetworkImage(
//           imageUrl: avatarUrl,
//           fit: BoxFit.cover,
//           width: 60,
//           height: 60,
//           placeholder: (context, url) => const Center(
//             child: CircularProgressIndicator(
//               strokeWidth: 2,
//               valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//             ),
//           ),
//           errorWidget: (context, url, error) => Image.asset(
//             "assets/images/logo.png",
//             height: 18,
//             color: Colors.white,
//             fit: BoxFit.contain,
//           ),
//         )
//             : Image.asset(
//           "assets/images/logo.png",
//           height: 18,
//           color: Colors.white,
//           fit: BoxFit.contain,
//         ),
//       ),
//     );
//   }
//
//   Widget _buildDetailRow(String label, String value, BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             label,
//             style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
//           ),
//           Text(
//             value,
//             style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black54),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
//
//
// // InkWell(
// //   onTap: () {
// //     context.push(AppRoutes.forgetPassword);
// //   },
// //   child: Row(
// //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //     children: [
// //       Text("Change Password",style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
// //       Icon(Icons.arrow_forward_ios_rounded, size: 18,color: Colors.grey,)
// //     ],
// //   ),
// // ),
// // SizedBox(height: 4,),