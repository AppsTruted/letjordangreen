import 'dart:convert';
import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:letjordangreen/core/functions/get_header_for_requests.dart';
import 'package:letjordangreen/core/hive/Hive_class.dart';
import 'package:letjordangreen/core/hive/user.dart';
import 'package:letjordangreen/core/utils/constants/constants.dart';
import 'package:letjordangreen/features/feature_auth/feature_login/data/models/Login_model.dart';
import 'package:letjordangreen/features/feature_auth/feature_login/data/models/error_model.dart';
import 'package:letjordangreen/features/feature_auth/feature_login/data/models/login_pin_model.dart';
import 'package:letjordangreen/features/feature_user_information/cubits/user_information_cubit/user_information_cubit.dart';


part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {

  LoginCubit() : super(LoginState.initial());

  setEmail(String email) {
    emit(state.copyWith(email: email, status: LoginStatus.initial));
  }

  setPassword( String password) {
    emit(state.copyWith( password: password , status: LoginStatus.initial));
  }

  Future<void> loginWithCredentials({required BuildContext context}) async {

  if(state.email.trim().isEmpty || state.password.trim().isEmpty) {
  //  showMessage("Please fill all information", true);
  } else {
  emit(state.copyWith(status: LoginStatus.loading));

  if (state.status == LoginStatus.submitting) return;
  emit(state.copyWith(status: LoginStatus.submitting));


  // try {


    final loginBody = {
      "email": state.email,
      "password": state.password,
      "rememberMe": ""
    };

    log(" loginBody  $loginBody");

    final response = await http.post(Uri.parse("$baseUrl/users/login"), body: loginBody);

    log(" response login ${response.body}");

      if(response.statusCode == 200) {
       var responseUser = loginModelFromJson(response.body);

        // -------------------------- save user --------------------------------
        final user = UserHiveModel(
              accessToken: responseUser.accessToken,
              id: responseUser.user?.id,
              name: responseUser.user?.name,
              username: responseUser.user?.email,
              password: state.password,
              phoneNumber: responseUser.user?.phoneNumber,
               roles: responseUser.user?.roles,
               languageId: "",
        );

        print("responseUser ${response.body}");

        UserBox.putBox('user', user);
        context.read<UserInformationCubit>().setUserHiveModel(user, state.password);
        // ----------------------------------------------------------------------
       emit(state.copyWith(status: LoginStatus.success,  loginModel: responseUser));
      }

   else if(response.statusCode == 403) {

      emit(state.copyWith(
          status: LoginStatus.error,
          error: errorModelFromJson(response.body).err ));
    }
    else {
      emit(state.copyWith(status: LoginStatus.error));
    }

  // } catch (error){
  //   emit(state.copyWith(status: LoginStatus.error));
  //   throw "__ $error";
  // }
}
  }

  // Future<void> loginWithPin({required BuildContext context}) async {
  //
  //
  //     emit(state.copyWith(status: LoginStatus.loading));
  //
  //     if (state.status == LoginStatus.submitting) return;
  //     emit(state.copyWith(status: LoginStatus.submitting));
  //
  //
  //     try {
  //
  //       final loginBody = {
  //         "pairingCode": state.email,
  //         "pin": state.password
  //       };
  //
  //       log("loginBody $loginBody");
  //
  //       final response = await http.post(Uri.parse("$baseUrl/devices/login-pin"), body: loginBody);
  //
  //       log(" response login ${response.statusCode} ${response.body} ");
  //
  //       if(response.statusCode == 200) {
  //         var responseUser = loginPinModelFromJson(response.body);
  //
  //         // -------------------------- save user --------------------------------
  //         final user = UserHiveModel(
  //           accessToken: responseUser.accessToken,
  //           id: responseUser.device?.user?.id,
  //           name: responseUser.device?.user?.fullName,
  //           password: state.password,
  //           restaurantId: responseUser.device?.restaurant,
  //           phoneNumber: responseUser.device?.user?.phoneNumber,
  //           roles: responseUser.device?.user?.roles,
  //           country: responseUser.device?.user?.country,
  //           branch: responseUser.device?.branch ??"",
  //           languageId: "",
  //           deviceType:  responseUser.device?.type ?? ""
  //         );
  //         UserBox.putBox('user', user);
  //         context.read<UserInformationCubit>().setUserHiveModel(user, state.password);
  //         // ----------------------------------------------------------------------
  //         emit(state.copyWith(status: LoginStatus.success));
  //       }
  //
  //       else if(response.statusCode == 403) {
  //         log("response.statusCode ${response.statusCode}");
  //
  //         emit(state.copyWith(
  //             status: LoginStatus.error,
  //             error: errorModelFromJson(response.body).err ));
  //       }
  //       else {
  //         log("else response.statusCode ${response.statusCode}");
  //
  //         emit(state.copyWith(status: LoginStatus.error, error: jsonDecode(response.body)['message']),);
  //       }
  //
  //     } catch (error){
  //       emit(state.copyWith(status: LoginStatus.error));
  //       throw "__ $error";
  //     }
  // }


  // initializeCubit() {
  //   emit(state.copyWith(status: LoginStatus.initial,email: "", password: "" ));
  // }

  Future<void> updateUserUnActive() async {

    final cubit = UserInformationCubit.instance;

    final userHiveModel = cubit.state.userHiveModel;

    final body = {
      "active": false,
    };

    final response = await http.put(Uri.parse("$baseUrl/users/${userHiveModel.id}"),
        body: json.encode(body),
        headers: getHeader(HeaderType.withContentType));


    log("updateUser ${response.body}");

  }

  // Future<void> updateUserFirebase() async {
  //   final cubit = UserInformationCubit.instance;
  //
  //   final userHiveModel = cubit.state.userHiveModel;
  //
  //   log("updateUserFirebase");
  //   LocalNotificationHandler.getToken().then((value) async {
  //
  //     final body = {
  //       "email": userHiveModel.username,
  //       "firebaseToken": value
  //     };
  //     log("updateUserFirebase body $body ${userHiveModel.username} ");
  //
  //     final response = await http.put(Uri.parse("$baseUrl/users/${userHiveModel.id}"), body: body,headers: getHeader(HeaderType.withToken));
  //     log("response response firebaseToken ${response.statusCode}");
  //
  //   });
  // }


}