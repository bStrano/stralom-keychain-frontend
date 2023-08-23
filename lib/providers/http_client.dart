import 'package:dio/dio.dart';
import 'package:keychain_frontend/constants/config.dart';

import '../interceptors/auth_interceptor.dart';

class AppHttpClient {
  static final AppHttpClient _instance = AppHttpClient._internal();
  final Dio dioClient = Dio(BaseOptions(
    baseUrl: Config.apiUrl,
  ));
  final Dio dioAuthenticatedClient = Dio(BaseOptions(baseUrl: Config.apiUrl));
  final Dio dioAuthClient = Dio(BaseOptions(
    baseUrl: Config.authApiUrl,
  ));
  factory AppHttpClient() {
    return _instance;
  }

  AppHttpClient._internal() {
    dioAuthenticatedClient.interceptors
        .add(AuthInterceptor(dioAuthenticatedClient));
  }

  Dio getAuthenticatedClient() {
    return dioAuthenticatedClient;
  }

  Dio getClient() {
    return dioClient;
  }

  Dio getAuthClient() {
    return dioAuthClient;
  }
}
