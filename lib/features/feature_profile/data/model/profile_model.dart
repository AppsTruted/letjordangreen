// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

import 'package:letjordangreen/features/feature_auth/feature_login/data/models/user.dart';


User profileModelFromJson(String str) => User.fromJson(json.decode(str));

String profileModelToJson(User data) => json.encode(data.toJson());

