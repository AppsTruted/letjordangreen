import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:letjordangreen/core/functions/get_header_for_requests.dart';
import 'package:letjordangreen/core/hive/user.dart';
import 'package:letjordangreen/core/states/base_states.dart';
import 'package:letjordangreen/core/utils/constants/constants.dart';
import 'package:letjordangreen/features/feature_map/data/models/public_map_model.dart';
import 'package:letjordangreen/features/feature_user_information/cubits/user_information_cubit/user_information_cubit.dart';


class PublicMapCubit extends Cubit<BaseState<List<PublicMapModel>>> {
  PublicMapCubit() : super(InitialState());

  List<PublicMapModel> projects = [];

  UserInformationCubit userInformationCubit = UserInformationCubit();
  late UserHiveModel userHiveModel;

  Future<List<PublicMapModel>> getTreesOnMap() async {
    userHiveModel = userInformationCubit.state.userHiveModel;
    try {

      emit(LoadingState());

      final response = await http.get(Uri.parse("$baseUrl/trees/public-map"),
          headers: getHeader(HeaderType.withToken)
      );

      debugPrint("get Projects ${response.body}  ");

      if (response.statusCode == 200) {
        projects = publicMapModelFromJson(response.body);

        emit(SuccessState( publicMapModelFromJson(response.body)));
        return publicMapModelFromJson(response.body);
      } else {
        emit(ErrorState());
        return publicMapModelFromJson(response.body);

      }
    } catch (e) {
      emit(ErrorState());
      return publicMapModelFromJson("");

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