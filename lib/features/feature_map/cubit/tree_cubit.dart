import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:letjordangreen/core/functions/get_header_for_requests.dart';
import 'package:letjordangreen/core/hive/user.dart';
import 'package:letjordangreen/core/states/base_states.dart';
import 'package:letjordangreen/core/utils/constants/constants.dart';
import 'package:letjordangreen/features/feature_map/data/models/tree_model.dart';
import 'package:letjordangreen/features/feature_user_information/cubits/user_information_cubit/user_information_cubit.dart';


class TreeCubit extends Cubit<BaseState<TreeModel>> {
  TreeCubit() : super(InitialState());

  TreeModel projects = TreeModel();

  UserInformationCubit userInformationCubit = UserInformationCubit();
  late UserHiveModel userHiveModel;

  Future<void> getTree(String code) async {
    userHiveModel = userInformationCubit.state.userHiveModel;
    try {

      emit(LoadingState());

      final response = await http.get(Uri.parse("$baseUrl/trees/track/$code"),
          headers: getHeader(HeaderType.withToken)
      );

      debugPrint("get tree ${(response.body)}  ");

      if (response.statusCode == 200) {
        projects = treeModelFromJson(response.body);

        emit(SuccessState( treeModelFromJson(response.body)));
      } else {
        emit(ErrorState());
      }
    } catch (e) {
      emit(ErrorState());

    }
  }

}