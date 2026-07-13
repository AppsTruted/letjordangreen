import 'dart:io';
import 'package:letjordangreen/features/feature_user_information/cubits/user_information_cubit/user_information_cubit.dart';

enum HeaderType { withToken, withContentType }

Map<String, String> getHeader(HeaderType type) {
  final cubit = UserInformationCubit.instance;


  final userHiveModel = cubit.state.userHiveModel;

  switch (type) {
    case HeaderType.withToken:
      return {
        HttpHeaders.authorizationHeader: 'Bearer ${userHiveModel.accessToken ?? ""}',
      };

    case HeaderType.withContentType:
      return {
        HttpHeaders.authorizationHeader: 'Bearer ${userHiveModel.accessToken ?? ""}',
        'Content-Type': 'application/json; charset=UTF-8',
      };

    default:
      return {};
  }
}


String replaceLocalhostWithIP(String url) {
  return url.replaceAll("localhost", "192.168.1.2");
}