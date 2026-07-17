// To parse this JSON data, do
//
//     final projectsModel = projectsModelFromJson(jsonString);

import 'dart:convert';

List<ProjectsModel> projectsModelFromJson(String str) => List<ProjectsModel>.from(json.decode(str).map((x) => ProjectsModel.fromJson(x)));

String projectsModelToJson(List<ProjectsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProjectsModel {
  String? id;
  String? name;
  String? location;
  dynamic? maxCapacity;
  dynamic? clientPricePerTree;
  dynamic? farmerPayoutPerTree;
  dynamic? assignedTreesCount;
  dynamic? plantedTreesCount;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic? v;

  ProjectsModel({
    this.id,
    this.name,
    this.location,
    this.maxCapacity,
    this.clientPricePerTree,
    this.farmerPayoutPerTree,
    this.assignedTreesCount,
    this.plantedTreesCount,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  ProjectsModel copyWith({
    String? id,
    String? name,
    String? location,
    dynamic? maxCapacity,
    dynamic? clientPricePerTree,
    dynamic? farmerPayoutPerTree,
    dynamic? assignedTreesCount,
    dynamic? plantedTreesCount,
    DateTime? createdAt,
    DateTime? updatedAt,
    dynamic? v,
  }) =>
      ProjectsModel(
        id: id ?? this.id,
        name: name ?? this.name,
        location: location ?? this.location,
        maxCapacity: maxCapacity ?? this.maxCapacity,
        clientPricePerTree: clientPricePerTree ?? this.clientPricePerTree,
        farmerPayoutPerTree: farmerPayoutPerTree ?? this.farmerPayoutPerTree,
        assignedTreesCount: assignedTreesCount ?? this.assignedTreesCount,
        plantedTreesCount: plantedTreesCount ?? this.plantedTreesCount,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        v: v ?? this.v,
      );

  factory ProjectsModel.fromJson(Map<String, dynamic> json) => ProjectsModel(
    id: json["_id"],
    name: json["name"],
    location: json["location"],
    maxCapacity: json["maxCapacity"],
    clientPricePerTree: json["clientPricePerTree"]?.toDouble(),
    farmerPayoutPerTree: json["farmerPayoutPerTree"]?.toDouble(),
    assignedTreesCount: json["assignedTreesCount"],
    plantedTreesCount: json["plantedTreesCount"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "location": location,
    "maxCapacity": maxCapacity,
    "clientPricePerTree": clientPricePerTree,
    "farmerPayoutPerTree": farmerPayoutPerTree,
    "assignedTreesCount": assignedTreesCount,
    "plantedTreesCount": plantedTreesCount,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
