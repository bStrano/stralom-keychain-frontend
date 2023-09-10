import 'package:dio/dio.dart';
import 'package:keychain_frontend/models/secret_detailed.dart';

import '../models/register_secret.dart';
import '../models/secret_basic_info.dart';
import '../providers/http_client.dart';

class VaultApi {
  VaultApi._();

  static const String baseUrl = '/vault';

  static Future<SecretDetailed> registerShareableSecret(
      RegisterSecret registerSecret) async {
    var requestOption = Options(
      method: 'POST',
    );
    Response response = await AppHttpClient().getClient().post(
        '$baseUrl/register',
        data: registerSecret.toJson(),
        options: requestOption);
    return SecretDetailed.fromJson(response.data);
  }

  static Future<SecretDetailed> visualizeShareableSecret(String id) async {
    var requestOption = Options(
      method: 'GET',
    );
    Response response = await AppHttpClient()
        .getClient()
        .post('$baseUrl/secrets/$id', options: requestOption);
    if (response.statusCode == 200) {
      return SecretDetailed.fromJson(response.data);
    } else {
      throw Exception('Failed to load vault secret');
    }
  }

  static Future<List<SecretBasicInfo>> findAll() async {
    var requestOption = Options(
      method: 'GET',
    );
    Response response = await AppHttpClient()
        .getAuthenticatedClient()
        .get('$baseUrl/secrets', options: requestOption);
    if (response.statusCode == 200) {
      return List.from(response.data.map((e) => SecretBasicInfo.fromJson(e)));
    } else {
      throw Exception('Failed to load vault secrets');
    }
  }

  static Future<void> register(RegisterSecret secret) async {
    var requestOption = Options(
      method: 'POST',
    );
    Response response = await AppHttpClient().getAuthenticatedClient().post(
        '$baseUrl/secrets',
        data: secret.toJson(),
        options: requestOption);
    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception('Failed to register vault secret');
    }
  }
}
