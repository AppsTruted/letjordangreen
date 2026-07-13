part of 'signup_cubit.dart';

enum SignUpStatus {initial, submitting, success, error, loading}

class SignupState extends Equatable {
  final String name;
  final String lastName;
  final String email;
  final String password;
  final String confirmPassword;
  final String phoneNumber;
  final String dateOfBirth;
  final SignUpStatus status;


  const SignupState({required this.name, required this.lastName,required this.email, required this.password, required this.confirmPassword,required this.phoneNumber,required this.status, required this.dateOfBirth});

  factory SignupState.initial(){
    return const SignupState(
      name: "",
      lastName: "",
      email: "" ,
      password: "",
      confirmPassword: "",
      phoneNumber: "",
      dateOfBirth: "",
      status: SignUpStatus.initial,
    );
  }

  SignupState copyWith({String? name,String? lastName,String? email, String? password, SignUpStatus? status, String? confirmPassword, String? phoneNumber, String? dateOfBirth}) {
    return SignupState(
      name: name ?? this.name,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      status: status ?? this.status,
    );
}

  @override
  List<Object?> get props => [name,lastName,email,password, confirmPassword, phoneNumber,dateOfBirth,status];
}
