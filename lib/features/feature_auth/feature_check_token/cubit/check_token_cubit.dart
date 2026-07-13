import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:letjordangreen/core/functions/get_header_for_requests.dart';
import 'package:letjordangreen/core/utils/constants/constants.dart';
import 'package:letjordangreen/features/feature_auth/feature_check_token/data/model/check_token_model.dart';

part 'check_token_state.dart';

class CheckTokenCubit extends Cubit<CheckTokenState> {
  CheckTokenCubit() : super(CheckTokenInitial());


  Future<CheckTokenModel> getCheckToken(BuildContext context) async {

    const url = "$baseUrl/users/check/JWT";

    try {

      final response = await get(Uri.parse(url),headers: getHeader(HeaderType.withToken));
      log("response statusCode getCheckToken  ${response.statusCode} ");

      if(response.statusCode == 200) {
        emit(CheckTokenDone(checkToken:  checkTokenModelFromJson(response.body)));
        return checkTokenModelFromJson(response.body);

      }
      if(response.statusCode == 401) {
     //   showMessage(unAuthorizedMessage, true);
        return  checkTokenModelFromJson(response.body);

      } else {
        emit(CheckTokenFailure());
        return CheckTokenModel();
      }
    } catch (err) {
      log("error getCheckToken  $err");
      emit(CheckTokenFailure());
      return CheckTokenModel();
    }
  }

  Future<CheckTokenModel> getCheckTokenDevice(BuildContext context) async {

    const url = "$baseUrl/users/check/device/JWT";

    try {

      final response = await get(Uri.parse(url),headers: getHeader(HeaderType.withToken));
      log("response statusCode getCheckToken  ${response.statusCode} ");

      if(response.statusCode == 200) {
        emit(CheckTokenDone(checkToken:  checkTokenModelFromJson(response.body)));
        return checkTokenModelFromJson(response.body);

      }
      if(response.statusCode == 401) {
     //   showMessage(unAuthorizedMessage, true);
        return  checkTokenModelFromJson(response.body);

      } else {
        emit(CheckTokenFailure());
        return CheckTokenModel();
      }
    } catch (err) {
      log("error getCheckToken  $err");
      emit(CheckTokenFailure());
      return CheckTokenModel();
    }
  }

}