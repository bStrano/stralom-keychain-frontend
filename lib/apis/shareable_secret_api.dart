import 'package:dio/dio.dart';
import 'package:keychain_frontend/enum/lifetime_enum.dart';
import 'package:keychain_frontend/models/register_shareable_secret.dart';
import 'package:keychain_frontend/providers/HttpClient.dart';

class ShareableSecretApi {
  ShareableSecretApi._();

  static const String baseUrl = '/shareable-secret';

  static List<Map<String, dynamic>> getLifetimeOptions() {
    return [
      {'label': '1 dia', 'value': LifetimeEnum.oneDay},
      {'label': '1 semana', 'value': LifetimeEnum.oneWeek},
      {
        'label': '1 mês',
        'value': LifetimeEnum.oneMonth,
      },
    ];
  }

  static List<Map<String, dynamic>> getViewCountOptions() {
    return [
      {'label': '1 visualização', 'value': 1},
      {'label': '2 visualizações', 'value': 2},
      {'label': '3 visualizações', 'value': 3},
    ];
  }

  static registerShareableSecret(
      RegisterShareableSecret registerShareableSecret) {
    var requestOption = RequestOptions(
      path: '$baseUrl/create',
      method: 'POST',
      data: registerShareableSecret.toJson(),
    );
    AppHttpClient().performAuthenticatedRequest(requestOption);
  }
}
