// To parse this JSON data, do
//
//     final treeModel = treeModelFromJson(jsonString);

import 'dart:convert';

TreeModel treeModelFromJson(String str) => TreeModel.fromJson(json.decode(str));

String treeModelToJson(TreeModel data) => json.encode(data.toJson());

class TreeModel {
  String? uniqueCode;
  String? status;
  List<String>? imageUrls;
  double? gpsLat;
  double? gpsLng;
  DateTime? plantingDate;
  String? projectName;
  String? farmerName;
  String? beneficiaryName;
  dynamic senderName;

  TreeModel({
    this.uniqueCode,
    this.status,
    this.imageUrls,
    this.gpsLat,
    this.gpsLng,
    this.plantingDate,
    this.projectName,
    this.farmerName,
    this.beneficiaryName,
    this.senderName,
  });

  TreeModel copyWith({
    String? uniqueCode,
    String? status,
    List<String>? imageUrls,
    double? gpsLat,
    double? gpsLng,
    DateTime? plantingDate,
    String? projectName,
    String? farmerName,
    String? beneficiaryName,
    dynamic senderName,
  }) =>
      TreeModel(
        uniqueCode: uniqueCode ?? this.uniqueCode,
        status: status ?? this.status,
        imageUrls: imageUrls ?? this.imageUrls,
        gpsLat: gpsLat ?? this.gpsLat,
        gpsLng: gpsLng ?? this.gpsLng,
        plantingDate: plantingDate ?? this.plantingDate,
        projectName: projectName ?? this.projectName,
        farmerName: farmerName ?? this.farmerName,
        beneficiaryName: beneficiaryName ?? this.beneficiaryName,
        senderName: senderName ?? this.senderName,
      );

  factory TreeModel.fromJson(Map<String, dynamic> json) => TreeModel(
    uniqueCode: json["uniqueCode"],
    status: json["status"],
    imageUrls: json["imageUrls"] == null ? [] : List<String>.from(json["imageUrls"]!.map((x) => x)),
    gpsLat: json["gpsLat"]?.toDouble(),
    gpsLng: json["gpsLng"]?.toDouble(),
    plantingDate: json["plantingDate"] == null ? null : DateTime.parse(json["plantingDate"]),
    projectName: json["projectName"],
    farmerName: json["farmerName"],
    beneficiaryName: json["beneficiaryName"],
    senderName: json["senderName"],
  );

  Map<String, dynamic> toJson() => {
    "uniqueCode": uniqueCode,
    "status": status,
    "imageUrls": imageUrls == null ? [] : List<dynamic>.from(imageUrls!.map((x) => x)),
    "gpsLat": gpsLat,
    "gpsLng": gpsLng,
    "plantingDate": plantingDate?.toIso8601String(),
    "projectName": projectName,
    "farmerName": farmerName,
    "beneficiaryName": beneficiaryName,
    "senderName": senderName,
  };
}
