class OtpVerficationModel {
  final String email;
  final String otp;

  OtpVerficationModel({required this.email, required this.otp});

  Map<String, dynamic> toJson() {
    return {
      'email': email, 
      'otp': otp
    };
  }
}
