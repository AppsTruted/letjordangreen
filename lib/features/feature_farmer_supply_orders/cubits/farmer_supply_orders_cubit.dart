import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:letjordangreen/core/functions/get_header_for_requests.dart';
import 'package:letjordangreen/core/hive/user.dart';
import 'package:letjordangreen/core/states/base_states.dart';
import 'package:letjordangreen/core/utils/constants/constants.dart';
import 'package:letjordangreen/features/feature_farmer_supply_orders/data/models/supply_orders_model.dart';
import 'package:letjordangreen/features/feature_user_information/cubits/user_information_cubit/user_information_cubit.dart';


class FarmerSupplyOrdersCubit extends Cubit<BaseState<List<SupplyOrdersModel>>> {
  FarmerSupplyOrdersCubit() : super(InitialState());

  List<SupplyOrdersModel> projects = [];

  UserInformationCubit userInformationCubit = UserInformationCubit();
  late UserHiveModel userHiveModel;

  Future<void> getMyOrders() async {
    userHiveModel = userInformationCubit.state.userHiveModel;
    try {

      emit(LoadingState());

      final response = await http.get(Uri.parse("$baseUrl/supply-orders/my"),
          headers: getHeader(HeaderType.withToken)
      );

      debugPrint(" get My Orders ${response.body}  ");

      if (response.statusCode == 200) {
        projects = supplyOrdersModelFromJson(response.body);

        emit(SuccessState( supplyOrdersModelFromJson(response.body)));
      } else {
        emit(ErrorState());

      }
    } catch (e) {
      emit(ErrorState());

    }
  }

  Future<void> updateOrder(String id) async {
    userHiveModel = userInformationCubit.state.userHiveModel;
    try {

      emit(LoadingState());

      final response = await http.get(Uri.parse("$baseUrl/supply-orders/$id/status"),
          headers: getHeader(HeaderType.withToken)
      );

      debugPrint(" updateOrder  ${response.body}  ");

      if (response.statusCode == 200) {

      } else {

      }
    } catch (e) {

    }
  }
  // void filterBranchesByName(String searchText) {
  //   List<BranchesModel> filtered = branches.where((branch) {
  //     return branch.name?.toLowerCase().contains(searchText.toLowerCase()) ?? false;
  //   }).toList();
  //
  //   emit(BranchesDoneSuccess(branches: filtered));
  // }

}