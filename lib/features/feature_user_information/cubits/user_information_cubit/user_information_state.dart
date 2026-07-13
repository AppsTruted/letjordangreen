import 'package:equatable/equatable.dart';
import 'package:letjordangreen/core/hive/user.dart';

class UserInformationState extends Equatable {
  final UserHiveModel userHiveModel;
  final bool isLoggedIn;

  const UserInformationState({
    required this.userHiveModel,
    required this.isLoggedIn,
  });

  @override
  List<Object?> get props => [userHiveModel, isLoggedIn];

  factory UserInformationState.initial() {
    return UserInformationState(
      userHiveModel: UserHiveModel(),
      isLoggedIn: false,
    );
  }

  UserInformationState copyWith({
    UserHiveModel? userHiveModel,
    bool? isLoggedIn,
  }) {
    return UserInformationState(
      userHiveModel: userHiveModel ?? this.userHiveModel,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
    );
  }
}