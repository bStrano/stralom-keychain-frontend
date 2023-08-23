import 'package:keychain_frontend/models/refresh_token.dart';

class LoginResponse {
  num id;
  String email;
  String name;
  String? lastName;
  String accessToken;
  RefreshToken refreshToken;

  LoginResponse.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        email = json['email'],
        name = json['name'],
        lastName = json['lastName'],
        accessToken = json['accessToken'],
        refreshToken = RefreshToken.fromJson(json['refreshToken']);
}
