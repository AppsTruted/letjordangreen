// To parse this JSON data, do
//
//     final checkTokenModel = checkTokenModelFromJson(jsonString);

import 'dart:convert';

import 'package:letjordangreen/features/feature_auth/feature_login/data/models/user.dart';


CheckTokenModel checkTokenModelFromJson(String str) => CheckTokenModel.fromJson(json.decode(str));

String checkTokenModelToJson(CheckTokenModel data) => json.encode(data.toJson());

class CheckTokenModel {
  String? status;
  String? accessToken;
  User? user;

  CheckTokenModel({
    this.status,
    this.accessToken,
    this.user,
  });

  factory CheckTokenModel.fromJson(Map<String, dynamic> json) => CheckTokenModel(
    status: json["status"],
    accessToken: json["accessToken"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "accessToken": accessToken,
    "user": user?.toJson(),
  };
}









