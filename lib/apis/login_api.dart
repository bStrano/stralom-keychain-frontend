import 'package:dio/dio.dart';
import 'package:keychain_frontend/models/login_request.dart';
import 'package:keychain_frontend/models/login_response.dart';
import 'package:keychain_frontend/providers/HttpClient.dart';

class LoginApi {
  LoginApi._();

  static const String baseUrl = '/auth';

  static Future<LoginResponse> login(LoginRequest loginRequest) async {
    var requestOption = Options(
      method: 'POST',
    );
    Response response = await AppHttpClient().getAuthClient().post(
        '$baseUrl/login',
        data: loginRequest.toJson(),
        options: requestOption);
    if (response.statusCode == 200) {
      return LoginResponse.fromJson(response.data);
    } else {
      throw Exception('Failed to load shareable secret');
    }
  }

  static Future<LoginResponse> loginSession(String refreshToken) async {
    var requestOption = Options(
      method: 'GET',
    );

    final Map<String, dynamic> data = Map<String, dynamic>();
    data['refreshToken'] = refreshToken;
    Response response = await AppHttpClient()
        .getAuthClient()
        .post('$baseUrl/session', options: requestOption);
    if (response.statusCode == 200) {
      return LoginResponse.fromJson(data);
    } else {
      throw Exception('Failed to load shareable secret');
    }
  }

  static Future<void> logout(String code) async {
    var requestOption = Options(
      method: 'DELETE',
    );

    await AppHttpClient()
        .getAuthClient()
        .get('$baseUrl/logout/$code', options: requestOption);
  }
}
