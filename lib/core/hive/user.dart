import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class UserHiveModel extends HiveObject {
  @HiveField(0)
  late String? accessToken;

  @HiveField(1)
  late String? id;


  @HiveField(2)
  late String? name;

  @HiveField(3)
  late String? username;

  @HiveField(4)
  late String? password;

  @HiveField(5)
  late String? restaurantId;

  @HiveField(6)
  late List<String>? roles;

  @HiveField(7)
  late String? language;

  @HiveField(8)
  late String? languageId;

  @HiveField(9)
  late bool? languageIsDefault;

  @HiveField(10)
  late String? phoneNumber;

  @HiveField(11)
  late String? country;


  @HiveField(12)
  late String? branch;

  @HiveField(13)
  late bool? eCommerceEnabled;

  @HiveField(14)
  late String? deviceType;

  @HiveField(15)
  late String? referralCode;

  @HiveField(16)
  late String? lastName;

  @HiveField(17)
  late DateTime? createdAt;

  @HiveField(18)
  late String? qrCodeToken;


  UserHiveModel(
      {this.accessToken,
      this.id,
      this.name,
        this.username,
        this.password,
        this.restaurantId,
        this.language='ar',
        this.languageId,
        this.languageIsDefault,
        this.roles,
        this.phoneNumber,
        this.country,
        this.branch,
        this.eCommerceEnabled,
        this.deviceType = "menu",
        this.referralCode="",
        this.lastName,
        this.qrCodeToken='',
        this.createdAt
  });


  @override
  String toString() {
    return 'UserHiveModel{accessToken: $accessToken, id: $id, name: $name, username: $username, password: $password, restaurantId: $restaurantId, roles: $roles, language: $language, languageId: $languageId, languageIsDefault: $languageIsDefault, phoneNumber: $phoneNumber, country: $country, branch: $branch, eCommerceEnabled: $eCommerceEnabled, deviceType: $deviceType, referralCode: $referralCode, lastName: $lastName, createdAt: $createdAt, qrCodeToken: $qrCodeToken}';
  }

  UserHiveModel copyWith({
    String? accessToken,
    String? id,
    String? name,
    String? username,
    String? password,
    String? restaurantId,
    List<String>? roles,
    String? language,
    String? languageId,
    bool? languageIsDefault,
    String? phoneNumber,
    String? country,
    String? branch,
    String? deviceType,
    String? referralCode,
    bool? eCommerceEnabled,
    String? lastName,
    DateTime? createdAt,
    String? qrCodeToken
  }) {
    return UserHiveModel(
        accessToken: accessToken ?? this.accessToken,
        id: id ?? this.id,
        name: name ?? this.name,
        username: username ?? this.username,
        password: password ?? this.password,
        restaurantId: restaurantId ?? this.restaurantId,
        roles: roles ?? this.roles,
        language: language ?? this.language,
        languageId: languageId ?? this.languageId,
        languageIsDefault: languageIsDefault ?? this.languageIsDefault,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        deviceType : deviceType ?? this.deviceType,
        country: country ?? this.country,
        branch: branch ?? this.branch,
        eCommerceEnabled: eCommerceEnabled ?? this.eCommerceEnabled,
        referralCode: referralCode ?? this.referralCode,
        lastName: lastName ?? this.lastName,
        createdAt: createdAt ?? this.createdAt,
        qrCodeToken : qrCodeToken ?? this.qrCodeToken
    );
  }
}