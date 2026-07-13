import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:letjordangreen/core/hive/Hive_class.dart';
import 'package:letjordangreen/core/hive/user.dart';
import 'package:letjordangreen/features/feature_user_information/cubits/user_information_cubit/user_information_state.dart';

class UserInformationCubit extends Cubit<UserInformationState> {
  static final UserInformationCubit _instance = UserInformationCubit._internal();

  factory UserInformationCubit() {
    return _instance;
  }

  UserHiveModel _userHiveModel = UserHiveModel();

  static UserInformationCubit get instance => _instance;

  UserInformationCubit._internal() : super(UserInformationState.initial());

  void setUserHiveModel(UserHiveModel user, String password) {
    try {
      final updatedUserModel = user.copyWith(password: password);

      emit(state.copyWith(
        userHiveModel: updatedUserModel.copyWith(
          id: updatedUserModel.id,
          name: updatedUserModel.name,
          username: updatedUserModel.username,
          accessToken: updatedUserModel.accessToken,
          password: updatedUserModel.password,
          restaurantId: updatedUserModel.restaurantId,
          roles: updatedUserModel.roles,
          languageId: updatedUserModel.languageId,
          languageIsDefault: updatedUserModel.languageIsDefault,
          language: updatedUserModel.language,
          phoneNumber: updatedUserModel.phoneNumber,
          country: updatedUserModel.country,
          branch: updatedUserModel.branch,
          deviceType: updatedUserModel.deviceType,
          eCommerceEnabled: updatedUserModel.eCommerceEnabled,
          referralCode: user.referralCode??""
        ),
        isLoggedIn: updatedUserModel.accessToken != null && updatedUserModel.accessToken!.isNotEmpty,
      ));
      _instance._userHiveModel = user;
    //  log("_instance._userHiveModel ${_instance._userHiveModel}");

    } catch (error) {
      debugPrint("Error setting user data: $error");
    }
  }

  Future<void> logout(BuildContext context) async {
    try {
      await UserBox.clearBox();
      _userHiveModel = UserHiveModel();
      emit(state.copyWith(
        userHiveModel: _userHiveModel,
        isLoggedIn: false,
      ));
      log("_userHiveModel logout $_userHiveModel");

    } catch (error) {
      debugPrint("Error during logout: $error");
    }
  }

  bool isUserLoggedIn() => state.isLoggedIn;
}