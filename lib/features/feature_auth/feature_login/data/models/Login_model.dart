// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

import 'package:letjordangreen/features/feature_auth/feature_login/data/models/user.dart';


LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  bool? success;
  String? accessToken;
  User? user;
  Device? device;

  LoginModel({
    this.success,
    this.accessToken,
    this.user,
    Device? device,
  });

  LoginModel copyWith({
    bool? success,
    String? status,
    String? accessToken,
    User? user,
    Device? device,
  }) =>
      LoginModel(
        success: success ?? this.success,
        accessToken: accessToken ?? this.accessToken,
        user: user ?? this.user,
        device: device ?? this.device,
      );

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    success: json["success"],
    accessToken: json["accessToken"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    device: json["device"] == null ? null : Device.fromJson(json["device"]),

  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "accessToken": accessToken,
    "user": user?.toJson(),
    "device": device?.toJson(),
  };
}


class Device {
  String? id;
  String? name;
  String? type;
  DeviceUser? user;
  String? restaurant;
  String? branch;
  String? pairingCode;
  bool? active;

  Device({
    this.id,
    this.name,
    this.type,
    this.user,
    this.restaurant,
    this.branch,
    this.pairingCode,
    this.active,
  });

  Device copyWith({
    String? id,
    String? name,
    String? type,
    DeviceUser? user,
    String? restaurant,
    String? branch,
    String? pairingCode,
    bool? active,
  }) =>
      Device(
        id: id ?? this.id,
        name: name ?? this.name,
        type: type ?? this.type,
        user: user ?? this.user,
        restaurant: restaurant ?? this.restaurant,
        branch: branch ?? this.branch,
        pairingCode: pairingCode ?? this.pairingCode,
        active: active ?? this.active,
      );

  factory Device.fromJson(Map<String, dynamic> json) => Device(
    id: json["_id"],
    name: json["name"],
    type: json["type"],
    user: json["user"] == null ? null : DeviceUser.fromJson(json["user"]),
    restaurant: json["restaurant"],
    branch: json["branch"],
    pairingCode: json["pairingCode"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "type": type,
    "user": user?.toJson(),
    "restaurant": restaurant,
    "branch": branch,
    "pairingCode": pairingCode,
    "active": active,
  };
}

class DeviceUser {
  String? id;
  String? fullName;
  List<String>? roles;
  String? phoneNumber;
  String? country;
  String? status;
  String? restaurantId;
  bool? active;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<dynamic>? locations;

  DeviceUser({
    this.id,
    this.fullName,
    this.roles,
    this.phoneNumber,
    this.country,
    this.status,
    this.restaurantId,
    this.active,
    this.createdAt,
    this.updatedAt,
    this.locations,
  });

  DeviceUser copyWith({
    String? id,
    String? fullName,
    List<String>? roles,
    String? phoneNumber,
    String? country,
    String? status,
    String? restaurantId,
    bool? active,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<dynamic>? locations,
  }) =>
      DeviceUser(
        id: id ?? this.id,
        fullName: fullName ?? this.fullName,
        roles: roles ?? this.roles,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        country: country ?? this.country,
        status: status ?? this.status,
        restaurantId: restaurantId ?? this.restaurantId,
        active: active ?? this.active,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        locations: locations ?? this.locations,
      );

  factory DeviceUser.fromJson(Map<String, dynamic> json) => DeviceUser(
    id: json["_id"],
    fullName: json["full_name"],
    roles: json["roles"] == null ? [] : List<String>.from(json["roles"]!.map((x) => x)),
    phoneNumber: json["phoneNumber"],
    country: json["country"],
    status: json["status"],
    restaurantId: json["restaurant_id"],
    active: json["active"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    locations: json["locations"] == null ? [] : List<dynamic>.from(json["locations"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "full_name": fullName,
    "roles": roles == null ? [] : List<dynamic>.from(roles!.map((x) => x)),
    "phoneNumber": phoneNumber,
    "country": country,
    "status": status,
    "restaurant_id": restaurantId,
    "active": active,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "locations": locations == null ? [] : List<dynamic>.from(locations!.map((x) => x)),
  };
}

class ProductModelUser {
  String? id;
  String? fullName;
  List<String>? roles;

  ProductModelUser({
    this.id,
    this.fullName,
    this.roles,
  });

  ProductModelUser copyWith({
    String? id,
    String? fullName,
    List<String>? roles,
  }) =>
      ProductModelUser(
        id: id ?? this.id,
        fullName: fullName ?? this.fullName,
        roles: roles ?? this.roles,
      );

  factory ProductModelUser.fromJson(Map<String, dynamic> json) => ProductModelUser(
    id: json["_id"],
    fullName: json["fullName"],
    roles: json["roles"] == null ? [] : List<String>.from(json["roles"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "fullName": fullName,
    "roles": roles == null ? [] : List<dynamic>.from(roles!.map((x) => x)),
  };
}