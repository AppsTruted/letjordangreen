// To parse this JSON data, do
//
//     final errorModel = errorModelFromJson(jsonString);

import 'dart:convert';

ErrorModel errorModelFromJson(String str) => ErrorModel.fromJson(json.decode(str));

String errorModelToJson(ErrorModel data) => json.encode(data.toJson());

class ErrorModel {
  bool? success;
  dynamic status;
  String? err;

  ErrorModel({
    this.success,
    this.status,
    this.err,
  });

  ErrorModel copyWith({
    bool? success,
    dynamic status,
    String? err,
  }) =>
      ErrorModel(
        success: success ?? this.success,
        status: status ?? this.status,
        err: err ?? this.err,
      );

  factory ErrorModel.fromJson(Map<String, dynamic> json) => ErrorModel(
    success: json["success"],
    status: json["status"],
    err: json["err"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "status": status,
    "err": err,
  };
}
