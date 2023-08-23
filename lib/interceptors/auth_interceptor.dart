import 'package:dio/dio.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:keychain_frontend/constants/storage.enum.dart';

import '../constants/config.dart';
import '../storage/local_storage.dart';

class AuthInterceptor extends Interceptor {
  bool locked = false;
  final Dio _dio;
  final _localStorage = LocalStorage();

  AuthInterceptor(this._dio);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.headers["requiresToken"] == false) {
      // if the request doesn't need token, then just continue to the next interceptor
      options.headers.remove("requiresToken"); //remove the auxiliary header
      return handler.next(options);
    }

    final accessToken = await _localStorage.restore(StorageEnum.accessToken);
    final refreshToken = await _localStorage.restore(StorageEnum.refreshToken);

    if (accessToken == null || refreshToken == null) {
      _performLogout(_dio);

      // create custom dio error
      options.extra["tokenErrorType"] = 'Token not found';
      final error =
          DioException(requestOptions: options, type: DioExceptionType.unknown);
      return handler.reject(error);
    }

    // check if tokens have already expired or not
    // I use jwt_decoder package
    // Note: ensure your tokens has "exp" claim
    final accessTokenHasExpired = JwtDecoder.isExpired(accessToken);
    final refreshTokenHasExpired = JwtDecoder.isExpired(refreshToken);

    var refreshed = true;

    if (refreshTokenHasExpired) {
      _performLogout(_dio);

      // create custom dio error
      options.extra["tokenErrorType"] = 'Refresh token has expired';
      final error =
          DioException(requestOptions: options, type: DioExceptionType.unknown);

      return handler.reject(error);
    } else if (accessTokenHasExpired) {
      // regenerate access token
      locked = true;
      refreshed = await _regenerateAccessToken();
      locked = false;
    }

    if (refreshed) {
      // add access token to the request header
      options.headers["Authorization"] = "Bearer $accessToken";
      return handler.next(options);
    } else {
      // create custom dio error
      options.extra["tokenErrorType"] = 'Failed to regenerate token';
      final error =
          DioException(requestOptions: options, type: DioExceptionType.unknown);
      return handler.reject(error);
    }
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 403 || err.response?.statusCode == 401) {
      // for some reasons the token can be invalidated before it is expired by the backend.
      // then we should navigate the user back to login page

      _performLogout(_dio);

      // create custom dio error
      // err.type = DioExceptionType.unknown;
      err.requestOptions.extra["tokenErrorType"] = 'Invalid acess token';
    }

    return handler.next(err);
  }

  void _performLogout(Dio dio) {
    locked = true;
    _localStorage.remove(StorageEnum.accessToken);
    _localStorage.remove(StorageEnum.refreshToken);

    // back to login page without using context
    // check this https://stackoverflow.com/a/53397266/9101876
    // navigatorKey.currentState?.pushReplacementNamed(LoginPage.routeName);

    locked = false;
  }

  /// return true if it is successfully regenerate the access token
  Future<bool> _regenerateAccessToken() async {
    try {
      var dio =
          Dio(); // should create new dio instance because the request interceptor is being locked

      // get refresh token from local storage
      final refreshToken = _localStorage.restore(StorageEnum.refreshToken);

      // make request to server to get the new access token from server using refresh token
      final response = await dio.post(
        "${Config.authApiUrl}/auth/session",
        data: {"refreshToken": refreshToken},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final newAccessToken = response
            .data["accessToken"]; // parse data based on your JSON structure
        _localStorage.store(
            StorageEnum.accessToken, newAccessToken); // save to local storage
        return true;
      } else if (response.statusCode == 401 || response.statusCode == 403) {
        // it means your refresh token no longer valid now, it may be revoked by the backend
        _performLogout(_dio);
        return false;
      } else {
        return false;
      }
    } on DioException {
      return false;
    } catch (e) {
      return false;
    }
  }
}
