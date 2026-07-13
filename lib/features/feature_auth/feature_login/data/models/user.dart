
import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

List<User> userListFromJson(String str) => List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String userListToJson(List<User> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class User {
  String? id;
  String? name;
  String? lastName;

  String? status;
  String? phoneNumber;
  List<String>? roles;
  bool? active;
  int? strikes;
  int? dailyLimit;
  bool? isEmailVerified;
  String? email;
  List<RefreshToken>? refreshTokens;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  DateTime? emailVerificationExpires;
  String? emailVerificationToken;
  Avatar? avatar;


  User({
    this.id,
    this.name,
    this.status,
    this.phoneNumber,
    this.roles,
    this.active,
    this.strikes,
    this.dailyLimit,
    this.isEmailVerified,
    this.email,
    this.lastName,

    this.refreshTokens,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.emailVerificationExpires,
    this.emailVerificationToken,
    this.avatar
  });

  User copyWith({
    String? id,
    String? name,
    String? status,
    String? phoneNumber,
    List<String>? roles,
    bool? active,
    String? lastName,

    int? strikes,
    int? dailyLimit,
    bool? isEmailVerified,
    String? email,
    List<RefreshToken>? refreshTokens,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
    DateTime? emailVerificationExpires,
    String? emailVerificationToken,
    Avatar? avatar
  }) =>
      User(
        id: id ?? this.id,
        name: name ?? this.name,
        status: status ?? this.status,
          lastName: lastName ?? this.lastName,

        phoneNumber: phoneNumber ?? this.phoneNumber,
        roles: roles ?? this.roles,
        active: active ?? this.active,
        strikes: strikes ?? this.strikes,
        dailyLimit: dailyLimit ?? this.dailyLimit,
        isEmailVerified: isEmailVerified ?? this.isEmailVerified,
        email: email ?? this.email,
        refreshTokens: refreshTokens ?? this.refreshTokens,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        v: v ?? this.v,
        emailVerificationExpires: emailVerificationExpires ?? this.emailVerificationExpires,
        emailVerificationToken: emailVerificationToken ?? this.emailVerificationToken,
        avatar: avatar ?? this.avatar
      );

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["_id"],
    name: json["name"],
    status: json["status"],
    lastName: json["last_name"],

    phoneNumber: json["phoneNumber"],
    roles: json["roles"] == null ? [] : List<String>.from(json["roles"]!.map((x) => x)),
    active: json["active"],
    strikes: json["strikes"],
    dailyLimit: json["dailyLimit"],
    isEmailVerified: json["isEmailVerified"],
    email: json["email"],
    refreshTokens: json["refreshTokens"] == null ? [] : List<RefreshToken>.from(json["refreshTokens"]!.map((x) => RefreshToken.fromJson(x))),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    emailVerificationExpires: json["emailVerificationExpires"] == null ? null : DateTime.parse(json["emailVerificationExpires"]),
    emailVerificationToken: json["emailVerificationToken"],
    // avatar: json["avatar"] == null ? null : Avatar.fromJson(json["avatar"]),

  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "status": status,
    "last_name": lastName,

    "phoneNumber": phoneNumber,
    "roles": roles == null ? [] : List<dynamic>.from(roles!.map((x) => x)),
    "active": active,
    "strikes": strikes,
    "dailyLimit": dailyLimit,
    "isEmailVerified": isEmailVerified,
    "email": email,
    "refreshTokens": refreshTokens == null ? [] : List<dynamic>.from(refreshTokens!.map((x) => x.toJson())),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "emailVerificationExpires": emailVerificationExpires?.toIso8601String(),
    "emailVerificationToken": emailVerificationToken,
    "avatar": avatar?.toJson(),

  };
}

class RefreshToken {
  String? tokenHash;
  String? userAgent;
  DateTime? expiresAt;
  String? id;
  DateTime? createdAt;

  RefreshToken({
    this.tokenHash,
    this.userAgent,
    this.expiresAt,
    this.id,
    this.createdAt,
  });

  RefreshToken copyWith({
    String? tokenHash,
    String? userAgent,
    DateTime? expiresAt,
    String? id,
    DateTime? createdAt,
  }) =>
      RefreshToken(
        tokenHash: tokenHash ?? this.tokenHash,
        userAgent: userAgent ?? this.userAgent,
        expiresAt: expiresAt ?? this.expiresAt,
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
      );

  factory RefreshToken.fromJson(Map<String, dynamic> json) => RefreshToken(
    tokenHash: json["tokenHash"],
    userAgent: json["userAgent"],
    expiresAt: json["expiresAt"] == null ? null : DateTime.parse(json["expiresAt"]),
    id: json["_id"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "tokenHash": tokenHash,
    "userAgent": userAgent,
    "expiresAt": expiresAt?.toIso8601String(),
    "_id": id,
    "createdAt": createdAt?.toIso8601String(),
  };
}
class Avatar {
  String? url;
  String? filename;
  String? originalName;

  Avatar({
    this.url,
    this.filename,
    this.originalName,

  });

  factory Avatar.fromJson(Map<String, dynamic> json) => Avatar(
    url: json["url"],
    filename: json["filename"],
    originalName: json["original_name"],

  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "filename": filename,
    "original_name": originalName,

  };
}