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
}
