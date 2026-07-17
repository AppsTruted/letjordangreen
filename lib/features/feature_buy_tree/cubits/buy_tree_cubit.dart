import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:letjordangreen/core/hive/user.dart';
import 'package:letjordangreen/core/utils/constants/constants.dart';
import 'package:letjordangreen/features/feature_buy_tree/data/models/order_model.dart';
import 'package:letjordangreen/features/feature_user_information/cubits/user_information_cubit/user_information_cubit.dart';

part 'buy_tree_state.dart';

class BuyTreeCubit extends Cubit<BuyTreeState> {

  BuyTreeCubit() : super(BuyTreeState.initial());

  setName( String name){
    emit(state.copyWith( name: name , status: Status.initial));
  }

  setPhone( String phone) {
    emit(state.copyWith( phone: phone ));
  }


  setProjectId( String projectId) {
    emit(state.copyWith( projectId: projectId ));
  }

  setEmail( String email) {
    emit(state.copyWith( email: email ));
  }
  UserInformationCubit userInformationCubit = UserInformationCubit();
  late UserHiveModel userHiveModel ;

  Future<OrderSuccessModel> buyTree() async {
    emit(state.copyWith(status: Status.loading));

    if (state.status == Status.submitting) return OrderSuccessModel();
    emit(state.copyWith(status: Status.submitting));

    userHiveModel = userInformationCubit.state.userHiveModel;

    final buyTree = {
      "projectId": state.projectId,
      "recipientEmail": state.email,
      "recipientName": state.name,
      "recipientPhone" : state.phone
    };

    log(" buyTree  $buyTree");


    try {
      final response = await http.post(Uri.parse("$baseUrl/tree-orders/single-gift"), body: buyTree,);



      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(state.copyWith(status: Status.success, orderSuccessModel: orderSuccessModelFromJson(response.body)));
        // Reset state after success
        // emit(BuyTreeState.initial());
        return orderSuccessModelFromJson(response.body); // Return the response for the widget to handle
      }
      else if (response.statusCode == 400) {
        // Handle validation errors
        emit(state.copyWith(
            status: Status.error,
            error:  'Something went wrong, please try again later'
        ));
        return orderSuccessModelFromJson(response.body); // Return the response for the widget to handle

      }
      return orderSuccessModelFromJson(response.body); // Return the response for the widget to handle

    } catch (e) {
      emit(state.copyWith(
          status: Status.error,
          error: 'Network error: ${e.toString()}'
      ));
      rethrow;
    } finally {
      // Ensure loading state is reset even if there's an error
      if (state.status != Status.success) {
        // Don't reset immediately if we want to show error state
      }
    }
  }
  initCubit(){
    emit(BuyTreeState.initial());
  }

}