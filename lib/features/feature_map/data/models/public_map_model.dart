// To parse this JSON data, do
//
//     final publicMapModel = publicMapModelFromJson(jsonString);

import 'dart:convert';

List<PublicMapModel> publicMapModelFromJson(String str) => List<PublicMapModel>.from(json.decode(str).map((x) => PublicMapModel.fromJson(x)));

String publicMapModelToJson(List<PublicMapModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PublicMapModel {
  double? lat;
  double? lng;

  PublicMapModel({
    this.lat,
    this.lng,
  });

  PublicMapModel copyWith({
    double? lat,
    double? lng,
  }) =>
      PublicMapModel(
        lat: lat ?? this.lat,
        lng: lng ?? this.lng,
      );

  factory PublicMapModel.fromJson(Map<String, dynamic> json) => PublicMapModel(
    lat: json["lat"]?.toDouble(),
    lng: json["lng"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "lat": lat,
    "lng": lng,
  };
}
