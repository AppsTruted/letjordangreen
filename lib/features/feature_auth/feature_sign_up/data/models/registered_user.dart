class RegisteredUser {
  String? name;
  String? lastName;
  String? email;
  String? password;
  String? confirmPassword;
  String? phoneNumber;


  RegisteredUser(
      {this.name,
      this.lastName,
      this.email,
      this.password,
      this.confirmPassword,
      this.phoneNumber});


  @override
  String toString() {
    return 'RegisteredUser{name: $name, lastName: $lastName, email: $email, password: $password, confirmPassword: $confirmPassword, phoneNumber: $phoneNumber}';
  }

}