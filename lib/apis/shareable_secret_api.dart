import 'package:dio/dio.dart';
import 'package:keychain_frontend/models/register_shareable_secret.dart';
import 'package:keychain_frontend/providers/HttpClient.dart';

import '../models/shareable_secret.dart';

class ShareableSecretApi {
  ShareableSecretApi._();

  static const String baseUrl = '/shareable-secrets';

  static Future<ShareableSecret> registerShareableSecret(
      RegisterShareableSecret registerShareableSecret) async {
    var requestOption = Options(
      method: 'POST',
    );
    Response response = await AppHttpClient().getClient().post(
        '$baseUrl/register',
        data: registerShareableSecret.toJson(),
        options: requestOption);
    return ShareableSecret.fromJson(response.data);
  }

  static Future<ShareableSecret> getShareableSecret(String id) async {
    var requestOption = Options(
      method: 'GET',
    );
    Response response = await AppHttpClient()
        .getClient()
        .post('$baseUrl/detail/$id', options: requestOption);
    if (response.statusCode == 200) {
      return ShareableSecret.fromJson(response.data);
    } else {
      throw Exception('Failed to load shareable secret');
    }
  }
}
