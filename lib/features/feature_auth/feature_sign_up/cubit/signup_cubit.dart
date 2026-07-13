import 'dart:convert';
import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:letjordangreen/core/utils/constants/constants.dart';
import 'package:letjordangreen/features/feature_auth/feature_sign_up/data/models/registered_user.dart';
import 'package:letjordangreen/widgets/show_message.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {

  SignupCubit() : super(SignupState.initial());

  setName(String name){
    emit(state.copyWith(name: name, status: SignUpStatus.initial));
  }
  setLastName(String lastName){
    emit(state.copyWith(lastName: lastName, status: SignUpStatus.initial));
  }

  setEmail(String email){
    emit(state.copyWith(email: email, status: SignUpStatus.initial));
  }

  setPassword( String password){
    emit(state.copyWith( password: password , status: SignUpStatus.initial));
  }

  setConfirmPassword( String confirmPassword){
    emit(state.copyWith( confirmPassword: confirmPassword , status: SignUpStatus.initial));
  }

  setPhoneNumber( String phoneNumber){
    emit(state.copyWith( phoneNumber: phoneNumber , status: SignUpStatus.initial));
  }
  setDateOfBirth( String dateOfBirth){
    emit(state.copyWith( dateOfBirth: dateOfBirth , status: SignUpStatus.initial));
  }

  Future<void> signupWithCredentials({ required BuildContext context, required RegisteredUser registeredUser}) async {

    emit(state.copyWith(status: SignUpStatus.loading));

    if (state.status == SignUpStatus.submitting) return;
    emit(state.copyWith(status: SignUpStatus.submitting));


    try{

      Map<String, String> header = {"Content-Type": "application/json"};

      final signupBody = jsonEncode({
        "active": true,
        "password": state.password,
        "email": state.email,
       // "lastname": state.name,
        "name": state.name,
       "phoneNumber": "965656565655",
        "role": "user",
     //   "status" : "pending"
      });
      final response = await http.post(Uri.parse("$baseUrl/users/signup"), body: signupBody,headers: header).timeout(const Duration(seconds: 10 ));

      log(" response sign up ${response.statusCode}  ${response.body}");

      if(response.statusCode == 200) {
        log(" ${response.statusCode} response sign up");
        emit(state.copyWith(status: SignUpStatus.success));
        emit(state.copyWith(status: SignUpStatus.initial));
      }
      else if (response.statusCode == 500) {
        showMessage("This email is already registered", true);
        emit(state.copyWith(status: SignUpStatus.error));
      }

    } catch (e){
      emit(state.copyWith(status: SignUpStatus.error));
      throw "__ $e";
    }
  }
}