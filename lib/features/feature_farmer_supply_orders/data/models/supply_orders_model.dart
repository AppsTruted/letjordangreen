// To parse this JSON data, do
//
//     final supplyOrdersModel = supplyOrdersModelFromJson(jsonString);

import 'dart:convert';

List<SupplyOrdersModel> supplyOrdersModelFromJson(String str) => List<SupplyOrdersModel>.from(json.decode(str).map((x) => SupplyOrdersModel.fromJson(x)));

String supplyOrdersModelToJson(List<SupplyOrdersModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SupplyOrdersModel {
  String? id;
  dynamic supplierId;
  String? farmerId;
  ProjectId? projectId;
  int? quantity;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  SupplyOrdersModel({
    this.id,
    this.supplierId,
    this.farmerId,
    this.projectId,
    this.quantity,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  SupplyOrdersModel copyWith({
    String? id,
    dynamic supplierId,
    String? farmerId,
    ProjectId? projectId,
    int? quantity,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
  }) =>
      SupplyOrdersModel(
        id: id ?? this.id,
        supplierId: supplierId ?? this.supplierId,
        farmerId: farmerId ?? this.farmerId,
        projectId: projectId ?? this.projectId,
        quantity: quantity ?? this.quantity,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        v: v ?? this.v,
      );

  factory SupplyOrdersModel.fromJson(Map<String, dynamic> json) => SupplyOrdersModel(
    id: json["_id"],
    supplierId: json["supplierId"],
    farmerId: json["farmerId"],
    projectId: json["projectId"] == null ? null : ProjectId.fromJson(json["projectId"]),
    quantity: json["quantity"],
    status: json["status"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "supplierId": supplierId,
    "farmerId": farmerId,
    "projectId": projectId?.toJson(),
    "quantity": quantity,
    "status": status,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class ProjectId {
  String? id;
  String? name;
  String? location;

  ProjectId({
    this.id,
    this.name,
    this.location,
  });

  ProjectId copyWith({
    String? id,
    String? name,
    String? location,
  }) =>
      ProjectId(
        id: id ?? this.id,
        name: name ?? this.name,
        location: location ?? this.location,
      );

  factory ProjectId.fromJson(Map<String, dynamic> json) => ProjectId(
    id: json["_id"],
    name: json["name"],
    location: json["location"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "location": location,
  };
}
