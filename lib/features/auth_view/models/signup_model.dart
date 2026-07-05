class SignupModel {
  final String userName;
  final String email;
  final String password;

  SignupModel({
    required this.userName,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'username': userName,
      'email': email,
      'password': password,
    };
  }
}