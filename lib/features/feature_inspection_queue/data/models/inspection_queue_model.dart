// To parse this JSON data, do
//
//     final inspectionQueueModel = inspectionQueueModelFromJson(jsonString);

import 'dart:convert';

InspectionQueueModel inspectionQueueModelFromJson(String str) => InspectionQueueModel.fromJson(json.decode(str));

String inspectionQueueModelToJson(InspectionQueueModel data) => json.encode(data.toJson());

class InspectionQueueModel {
  List<Doc>? docs;
  int? totalDocs;
  int? totalPages;
  int? currentPage;
  int? limit;

  InspectionQueueModel({
    this.docs,
    this.totalDocs,
    this.totalPages,
    this.currentPage,
    this.limit,
  });

  InspectionQueueModel copyWith({
    List<Doc>? docs,
    int? totalDocs,
    int? totalPages,
    int? currentPage,
    int? limit,
  }) =>
      InspectionQueueModel(
        docs: docs ?? this.docs,
        totalDocs: totalDocs ?? this.totalDocs,
        totalPages: totalPages ?? this.totalPages,
        currentPage: currentPage ?? this.currentPage,
        limit: limit ?? this.limit,
      );

  factory InspectionQueueModel.fromJson(Map<String, dynamic> json) => InspectionQueueModel(
    docs: json["docs"] == null ? [] : List<Doc>.from(json["docs"]!.map((x) => Doc.fromJson(x))),
    totalDocs: json["totalDocs"],
    totalPages: json["totalPages"],
    currentPage: json["currentPage"],
    limit: json["limit"],
  );

  Map<String, dynamic> toJson() => {
    "docs": docs == null ? [] : List<dynamic>.from(docs!.map((x) => x.toJson())),
    "totalDocs": totalDocs,
    "totalPages": totalPages,
    "currentPage": currentPage,
    "limit": limit,
  };
}

class Doc {
  Coordinates? coordinates;
  String? id;
  String? uniqueCode;
  FarmerId? farmerId;
  ProjectId? projectId;
  String? ownerName;
  String? ownerEmail;
  String? ownerPhone;
  List<String>? imageUrls;
  String? verificationStatus;
  dynamic rejectionReason;
  int? rejectionCount;
  dynamic payoutAmount;
  String? payoutStatus;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Doc({
    this.coordinates,
    this.id,
    this.uniqueCode,
    this.farmerId,
    this.projectId,
    this.ownerName,
    this.ownerEmail,
    this.ownerPhone,
    this.imageUrls,
    this.verificationStatus,
    this.rejectionReason,
    this.rejectionCount,
    this.payoutAmount,
    this.payoutStatus,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  Doc copyWith({
    Coordinates? coordinates,
    String? id,
    String? uniqueCode,
    FarmerId? farmerId,
    ProjectId? projectId,
    String? ownerName,
    String? ownerEmail,
    String? ownerPhone,
    List<String>? imageUrls,
    String? verificationStatus,
    dynamic rejectionReason,
    int? rejectionCount,
    dynamic payoutAmount,
    String? payoutStatus,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
  }) =>
      Doc(
        coordinates: coordinates ?? this.coordinates,
        id: id ?? this.id,
        uniqueCode: uniqueCode ?? this.uniqueCode,
        farmerId: farmerId ?? this.farmerId,
        projectId: projectId ?? this.projectId,
        ownerName: ownerName ?? this.ownerName,
        ownerEmail: ownerEmail ?? this.ownerEmail,
        ownerPhone: ownerPhone ?? this.ownerPhone,
        imageUrls: imageUrls ?? this.imageUrls,
        verificationStatus: verificationStatus ?? this.verificationStatus,
        rejectionReason: rejectionReason ?? this.rejectionReason,
        rejectionCount: rejectionCount ?? this.rejectionCount,
        payoutAmount: payoutAmount ?? this.payoutAmount,
        payoutStatus: payoutStatus ?? this.payoutStatus,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        v: v ?? this.v,
      );

  factory Doc.fromJson(Map<String, dynamic> json) => Doc(
    coordinates: json["coordinates"] == null ? null : Coordinates.fromJson(json["coordinates"]),
    id: json["_id"],
    uniqueCode: json["uniqueCode"],
    farmerId: json["farmerId"] == null ? null : FarmerId.fromJson(json["farmerId"]),
    projectId: json["projectId"] == null ? null : ProjectId.fromJson(json["projectId"]),
    ownerName: json["ownerName"],
    ownerEmail: json["ownerEmail"],
    ownerPhone: json["ownerPhone"],
    imageUrls: json["imageUrls"] == null ? [] : List<String>.from(json["imageUrls"]!.map((x) => x)),
    verificationStatus: json["verificationStatus"],
    rejectionReason: json["rejectionReason"],
    rejectionCount: json["rejectionCount"],
    payoutAmount: json["payoutAmount"],
    payoutStatus: json["payoutStatus"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "coordinates": coordinates?.toJson(),
    "_id": id,
    "uniqueCode": uniqueCode,
    "farmerId": farmerId?.toJson(),
    "projectId": projectId?.toJson(),
    "ownerName": ownerName,
    "ownerEmail": ownerEmail,
    "ownerPhone": ownerPhone,
    "imageUrls": imageUrls == null ? [] : List<dynamic>.from(imageUrls!.map((x) => x)),
    "verificationStatus": verificationStatus,
    "rejectionReason": rejectionReason,
    "rejectionCount": rejectionCount,
    "payoutAmount": payoutAmount,
    "payoutStatus": payoutStatus,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class Coordinates {
  double? lat;
  double? lng;

  Coordinates({
    this.lat,
    this.lng,
  });

  Coordinates copyWith({
    double? lat,
    double? lng,
  }) =>
      Coordinates(
        lat: lat ?? this.lat,
        lng: lng ?? this.lng,
      );

  factory Coordinates.fromJson(Map<String, dynamic> json) => Coordinates(
    lat: json["lat"]?.toDouble(),
    lng: json["lng"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "lat": lat,
    "lng": lng,
  };
}

class FarmerId {
  String? id;
  String? name;
  String? email;

  FarmerId({
    this.id,
    this.name,
    this.email,
  });

  FarmerId copyWith({
    String? id,
    String? name,
    String? email,
  }) =>
      FarmerId(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
      );

  factory FarmerId.fromJson(Map<String, dynamic> json) => FarmerId(
    id: json["_id"],
    name: json["name"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "email": email,
  };
}

class ProjectId {
  String? id;
  String? name;

  ProjectId({
    this.id,
    this.name,
  });

  ProjectId copyWith({
    String? id,
    String? name,
  }) =>
      ProjectId(
        id: id ?? this.id,
        name: name ?? this.name,
      );

  factory ProjectId.fromJson(Map<String, dynamic> json) => ProjectId(
    id: json["_id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
  };
}
