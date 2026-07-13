import 'dart:convert';
import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:letjordangreen/core/functions/get_header_for_requests.dart';
import 'package:letjordangreen/core/utils/constants/constants.dart';
import 'package:letjordangreen/features/feature_auth/feature_login/data/models/user.dart';
import 'package:letjordangreen/features/feature_user_information/cubits/user_information_cubit/user_information_cubit.dart';
import 'package:letjordangreen/widgets/show_message.dart';
part 'edit_user_profile_state.dart';

class EditUserProfileCubit extends Cubit<EditUserProfileState> {

  EditUserProfileCubit() : super(EditUserProfileState.initial());
  final cubit = UserInformationCubit.instance;

  setName(String name){
    emit(state.copyWith( name: name, status: StatusEditProfile.initial));
  }
  void setBirthdate(DateTime birthdate) {
    emit(state.copyWith(birthDate: birthdate));
  }
  setLastName(String lastName){
    emit(state.copyWith( lastName: lastName, status: StatusEditProfile.initial));
  }
  setCountryCode(String countryCode) {
    emit(state.copyWith( countryCode: countryCode, status: StatusEditProfile.initial));
  }
  setPhoneNumber(String phoneNumber){
    emit(state.copyWith( phoneNumber: phoneNumber, status: StatusEditProfile.initial));
  }

  setProfileImage(Avatar uploadedImage) {
    emit(state.copyWith(uploadedImage: uploadedImage, status: StatusEditProfile.initial));
  }


  Future<void> updateUserProfile() async {
    if(state.name.isEmpty   ) {
      showMessage("Please fill all information", true);
    } else {

      emit(state.copyWith(status: StatusEditProfile.loading));

      if (state.status == StatusEditProfile.submitting) return;
      emit(state.copyWith(status: StatusEditProfile.submitting));
      try {
        final userHiveModel = cubit.state.userHiveModel;

        final url = "$baseUrl/users/${userHiveModel.id}";


        final userProfileBody = json.encode({
          "first_name": state.name,
          "last_name" : state.lastName,
          "phoneNumber": state.phoneNumber,
          "avatar" : state.uploadedImage.filename,
          "birthdate" : state.birthDate.toLocal().toIso8601String(),
        });
        log("try edit profile body $userProfileBody");

       final response = await http.put(Uri.parse(url), body:  userProfileBody, headers: getHeader(HeaderType.withContentType));
       log("edit profile ${response.statusCode}  ${response.body}");

        if(response.statusCode == 200) {
          log("${response.body} edit profile");
          emit(state.copyWith(status: StatusEditProfile.success));
          emit(state.copyWith(status: StatusEditProfile.initial));
          showMessage("Profile updated successfully", false);

        } else if(response.statusCode == 401) {
          showMessage(unAuthorizedMessage, true);
        }

      } catch (err) {
        log("err edit profile $err");
        emit(state.copyWith(status: StatusEditProfile.error));

      }
    }
  }

  initializeCubit(){
    emit(state.copyWith(status: StatusEditProfile.initial));
  }


}