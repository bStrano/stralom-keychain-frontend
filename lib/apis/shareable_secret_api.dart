import 'package:dio/dio.dart';
import 'package:keychain_frontend/models/register_shareable_secret.dart';
import 'package:keychain_frontend/models/shareable_secret_metadata.dart';
import 'package:keychain_frontend/providers/http_client.dart';

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

  static Future<ShareableSecret> visualizeShareableSecret(String id) async {
    var requestOption = Options(
      method: 'GET',
    );
    Response response = await AppHttpClient()
        .getClient()
        .post('$baseUrl/visualize/$id', options: requestOption);
    if (response.statusCode == 200) {
      return ShareableSecret.fromJson(response.data);
    } else {
      throw Exception('Failed to load shareable secret');
    }
  }

  static Future<ShareableSecretMetadata> getShareableSecretMetadata(
      String id) async {
    var requestOption = Options(
      method: 'GET',
    );
    Response response = await AppHttpClient()
        .getClient()
        .get('$baseUrl/metadata/$id', options: requestOption);
    if (response.statusCode == 200) {
      return ShareableSecretMetadata.fromJson(response.data);
    } else {
      throw Exception('Failed to load shareable secret');
    }
  }
}
