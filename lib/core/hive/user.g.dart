// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserHiveModelAdapter extends TypeAdapter<UserHiveModel> {
  @override
  final int typeId = 0;

  @override
  UserHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserHiveModel(
      accessToken: fields[0] as String?,
      id: fields[1] as String?,
      name: fields[2] as String?,
      username: fields[3] as String?,
      password: fields[4] as String?,
      restaurantId: fields[5] as String?,
      language: fields[7] as String?,
      languageId: fields[8] as String?,
      languageIsDefault: fields[9] as bool?,
      roles: (fields[6] as List?)?.cast<String>(),
      phoneNumber: fields[10] as String?,
      country: fields[11] as String?,
      branch: fields[12] as String?,
      eCommerceEnabled: fields[13] as bool?,
      deviceType: fields[14] as String?,
      referralCode: fields[15] as String?,
      lastName: fields[16] as String?,
      qrCodeToken: fields[18] as String?,
      createdAt: fields[17] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, UserHiveModel obj) {
    writer
      ..writeByte(19)
      ..writeByte(0)
      ..write(obj.accessToken)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.username)
      ..writeByte(4)
      ..write(obj.password)
      ..writeByte(5)
      ..write(obj.restaurantId)
      ..writeByte(6)
      ..write(obj.roles)
      ..writeByte(7)
      ..write(obj.language)
      ..writeByte(8)
      ..write(obj.languageId)
      ..writeByte(9)
      ..write(obj.languageIsDefault)
      ..writeByte(10)
      ..write(obj.phoneNumber)
      ..writeByte(11)
      ..write(obj.country)
      ..writeByte(12)
      ..write(obj.branch)
      ..writeByte(13)
      ..write(obj.eCommerceEnabled)
      ..writeByte(14)
      ..write(obj.deviceType)
      ..writeByte(15)
      ..write(obj.referralCode)
      ..writeByte(16)
      ..write(obj.lastName)
      ..writeByte(17)
      ..write(obj.createdAt)
      ..writeByte(18)
      ..write(obj.qrCodeToken);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
