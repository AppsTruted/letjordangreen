part of 'login_cubit.dart';

enum LoginStatus {initial, submitting, success, error, loading}

class LoginState extends Equatable {
  final String email;
  final String password;
  final LoginStatus status;
  final LoginModel? loginModel;
  final String? error;


  const LoginState({required this.email, required this.password, required this.status, required this.error, this.loginModel});

  factory LoginState.initial(){
    return  LoginState(
      email: "" ,
      password: "",
      error :"",
      status: LoginStatus.initial,
      loginModel: LoginModel()
      // userBody: UserBodyModel
    );
  }

  LoginState copyWith({String? email, String? password, LoginStatus? status,String? error,  LoginModel? loginModel}) {
    return LoginState(
        email: email ?? this.email,
        password: password ?? this.password,
        status: status ?? this.status,
        error: error ?? this.error,
        loginModel: loginModel ?? this.loginModel
    );
}

  @override
  List<Object?> get props => [email,password,status,error, loginModel];
}
