//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hyvermenu/core/hive/Hive_class.dart';
// import 'package:hyvermenu/core/hive/user.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:hyvermenu/features/feature_user_information/cubits/user_information_cubit/user_information_cubit.dart';
//
// Future<UserHiveModel> getUserInfo() async {
//
//   UserBox.getInstance();
//
//   Box<UserHiveModel>? x = await UserBox.getUserBox();
//
//   if(x?.get("user") != null) {
//     return x!.get("user")!;
//   }
//   else {
//     return UserHiveModel();
//   }
//
// }
//
// putUserInfo(BuildContext context,{String? branchId}) async {
//
//   final userBox = await UserBox.getUserBox();
//   final userData = userBox?.get("user");
//   userData?.branch = branchId;
//
//   UserBox.putBox('user', userData!);
//   context.read<UserInformationCubit>().setUserHiveModel(userData, userData.password??"");
//
// }