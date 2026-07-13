//
// import 'dart:developer';
//
//
// bool isLoggedIn(){
//   final cubit = UserInformationCubit.instance;
//   final userHiveModel = cubit.state.userHiveModel;
//   return !(userHiveModel.id == "" || userHiveModel.id == null);
// }
//
// bool isBusiness() {
//   final cubit = UserInformationCubit.instance;
//   final userHiveModel = cubit.state.userHiveModel;
//   return userHiveModel.roles!.contains("business");
// }
//
// bool isArabic() {
//   final cubit = UserInformationCubit.instance;
//   final userHiveModel = cubit.state.userHiveModel;
//   log("userHiveModel.language!.contains ${userHiveModel.language!.contains("ar")}");
//   return userHiveModel.language!.contains("ar");
// }