import 'package:dio/dio.dart';

import '../constants/config.dart';

class AppHttpClient {
  static final AppHttpClient _instance = AppHttpClient._internal();
  final Dio dioClient = Dio(BaseOptions(
    baseUrl: Config.apiUrl,
  ));
  factory AppHttpClient() {
    return _instance;
  }

  AppHttpClient._internal();

  performUnauthenticatedRequest(RequestOptions requestOptions) async {
    dioClient.fetch(requestOptions);
  }

  performAuthenticatedRequest(RequestOptions requestOptions) async {
    // TODO: Add authentication logic
    dioClient.fetch(requestOptions);
  }
}
