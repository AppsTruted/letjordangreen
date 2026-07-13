import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:letjordangreen/core/functions/get_header_for_requests.dart';
import 'package:letjordangreen/core/utils/constants/constants.dart';
import 'package:letjordangreen/features/feature_auth/feature_login/data/models/user.dart';
import 'package:letjordangreen/features/feature_user_information/cubits/user_information_cubit/user_information_cubit.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  final cubit = UserInformationCubit.instance;
  final url = "$baseUrl/users";

  Future<void> getUserProfile() async {

    final userHiveModel = cubit.state.userHiveModel;

    try {

      final response = await http.get(Uri.parse("$url/${userHiveModel.id}"),headers: getHeader(HeaderType.withToken));

      log("response getUserProfile ${response.body.toString()}");

      if(response.statusCode == 200) {
       log("response.statusCode profile  ${(response.statusCode)}");


        emit(ProfileDone(profile:  userFromJson(response.body)));

      } else if(response.statusCode == 401) {
        // showMessage(unAuthorizedMessage, true);

      }

    } catch (err) {
      log("error profile data  source $err");
      emit(ProfileFailure());
    }
  }

}