import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:letjordangreen/core/functions/get_header_for_requests.dart';
import 'package:letjordangreen/core/hive/user.dart';
import 'package:letjordangreen/core/states/base_states.dart';
import 'package:letjordangreen/core/utils/constants/constants.dart';
import 'package:letjordangreen/features/feature_projects/data/models/projects_model.dart';
import 'package:letjordangreen/features/feature_user_information/cubits/user_information_cubit/user_information_cubit.dart';


class ProjectsCubit extends Cubit<BaseState<List<ProjectsModel>>> {
  ProjectsCubit() : super(InitialState());

  List<ProjectsModel> projects = [];

  UserInformationCubit userInformationCubit = UserInformationCubit();
  late UserHiveModel userHiveModel;

  Future<List<ProjectsModel>> getProjects() async {
    userHiveModel = userInformationCubit.state.userHiveModel;
    try {

      emit(LoadingState());

      final response = await http.get(Uri.parse("$baseUrl/projects"),
          headers: getHeader(HeaderType.withToken)
      );

      debugPrint("get Projects ${response.body}  ");

      if (response.statusCode == 200) {
        projects = projectsModelFromJson(response.body);

        emit(SuccessState( projectsModelFromJson(response.body)));
        return projectsModelFromJson(response.body);
      } else {
        emit(ErrorState());
        return projectsModelFromJson(response.body);

      }
    } catch (e) {
      emit(ErrorState());
      return projectsModelFromJson("");

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