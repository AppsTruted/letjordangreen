part of 'edit_user_profile_cubit.dart';

enum StatusEditProfile {initial, submitting, success, error, loading}

class EditUserProfileState extends Equatable {
  final String name;
  final String lastName;
  final String phoneNumber;
  final Avatar uploadedImage;
  final String? countryCode;
  final DateTime birthDate;

  final StatusEditProfile status;


  const EditUserProfileState(
      {required this.name,
        required this.phoneNumber,
        required this.uploadedImage,
        required this.lastName,
        required this.countryCode,
        required this.birthDate,
        required this.status});

  factory EditUserProfileState.initial(){
    return  EditUserProfileState(
      name: "",
      phoneNumber: "",
      uploadedImage: Avatar(),
      lastName: "",
      birthDate: DateTime.now(),
      countryCode: "jo",
      status: StatusEditProfile.initial,
    );
  }

  EditUserProfileState copyWith({String? name,DateTime? birthDate,String? phoneNumber,String? countryCode, Avatar? uploadedImage, String? lastName,StatusEditProfile? status,

  }) {
    return EditUserProfileState(
      name: name ?? this.name,
      countryCode: countryCode ?? this.countryCode,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      uploadedImage: uploadedImage ?? this.uploadedImage,
      lastName: lastName ?? this.lastName,
      status: status ?? this.status,
        birthDate: birthDate ?? this.birthDate
    );
}

  @override
  // TODO: implement props
  List<Object?> get props => [name,phoneNumber,birthDate,countryCode, uploadedImage, lastName,status];
}



