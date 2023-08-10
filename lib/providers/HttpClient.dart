import 'package:dio/dio.dart';
import 'package:keychain_frontend/constants/config.dart';

class AppHttpClient {
  static final AppHttpClient _instance = AppHttpClient._internal();
  final Dio dioClient = Dio(BaseOptions(
    baseUrl: Config.apiUrl,
  ));
  factory AppHttpClient() {
    return _instance;
  }

  AppHttpClient._internal();

  Dio getClient() {
    return dioClient;
  }
}
