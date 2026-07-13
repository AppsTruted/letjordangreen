// import 'package:e_commerce/core/router/routes_names.dart';
// import 'package:e_commerce/core/utils/app_colors.dart';
// import 'package:e_commerce/core/utils/constants.dart';
// import 'package:e_commerce/features/feature_profile/widgets/profile_image.dart';
// import 'package:e_commerce/features/feature_user_information/cubits/user_information_cubit/user_information_cubit.dart';
// import 'package:e_commerce/features/feature_user_information/cubits/user_information_cubit/user_information_state.dart';
// import 'package:e_commerce/features/widgets/sized_box.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:go_router/go_router.dart';
//
// class DrawerHeaderWidget extends StatelessWidget {
//
//   @override
//   Widget build(BuildContext context) {
//
//     return BlocBuilder<UserInformationCubit, UserInformationState>(
//   builder: (context, state) {
//     return Padding(
//       padding: EdgeInsets.all(KPadding),
//       child: Column(
//         children: [
//           Align(alignment: Alignment.topLeft,child: Padding(
//             padding: const EdgeInsets.only(left: 4),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 InkWell(child: Icon(Icons.arrow_back_ios),onTap: (){
//                   Navigator.pop(context);
//                 }),
//                 Text("Profile", style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 18),),
//                 SizedBox(width: 40)
//               ],
//             ),
//           )),
//           AppSizedBox(),
//           Card(
//             child: Padding(
//               padding: const EdgeInsets.only(left: 12, right: 12,top: 20, bottom: 12),
//               child: Column(
//                 children: [
//                   Row(
//                     children: [
//                       if (state.isLoggedIn)
//                         SizedBox(
//                             height: 55,width: 55,
//                             child: ProfileImage("drawer")
//                         ),
//
//
//                       Padding(
//                         padding: const EdgeInsets.all(12.0),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisSize: MainAxisSize.min,
//                           children:   [
//                             if (state.isLoggedIn)
//                               Text(
//                                   "${state.userHiveModel.name??""}",
//                                   style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
//
//                             if (state.isLoggedIn)
//                               Text(
//                                   state.userHiveModel.username??"",
//                                   style: Theme.of(context).textTheme.bodyMedium)
//                             else
//                               SvgPicture.asset('assets/svg/logo_Saf.svg',color: primaryColor,height: 35,width: 35 )
//
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//
//                   if (state.isLoggedIn)
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         SvgPicture.asset("assets/svg/checkmark.svg", height: 16,),
//                         Text(" Verified"),
//                         Spacer(),
//                         SizedBox(
//                           width: 90,
//                           child: Padding(
//                             padding: const EdgeInsets.only(top: 2.0),
//                             child: MaterialButton(
//                                 elevation: 1,
//                                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//                                 color: primaryColor,
//                                 onPressed: (){
//                                   context.push(AppRoutes.profile);
//                                 },
//                                 child: Row(
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   children: [
//                                     SvgPicture.asset("assets/svg/edit.svg",height: 16, color: Colors.white,),
//                                     Text("  Edit", style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),)
//                                   ],
//                                 )),
//                           ),
//                         ),
//                       ],
//                     )
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   },
// );
//   }
// }
