import 'package:cuida_pet_modular_mobx/app/core/helpers/constants.dart';
import 'package:cuida_pet_modular_mobx/app/core/local_storage/local_storage.dart';
import 'package:cuida_pet_modular_mobx/app/modules/core/auth/auth_store.dart';
import 'package:dio/dio.dart';

class AuthInterceptors extends Interceptor {
  final LocalStorage _localStorage;
  final AuthStore _authStore;

  AuthInterceptors(
      {required LocalStorage localStorage,
      required AuthStore authStore})
      : _localStorage = localStorage,
        _authStore = authStore;

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final authRequired =
        options.extra[Constants.REST_CLIENT_AUTH_REQUIRED_KEY] ?? false;
    if (authRequired) {
      final accessToken = await _localStorage
          .read<String>(Constants.LOCAL_STORAGE_ACCESS_TOKEN_KEY);

      if (accessToken == null) {
        await _authStore.logout();
        return handler.reject(DioException(
            requestOptions: options,
            error: 'Expire Token',
            type: DioExceptionType.cancel));
      }

      options.headers['Authorization'] = accessToken;
    } else {
      options.headers.remove('Authorization');
    }
    handler.next(options);
  }

  // @override
  // void onResponse(Response response, ResponseInterceptorHandler handler) {
  //   super.onResponse(response, handler);
  // }

  // @override
  // void onError(DioException err, ErrorInterceptorHandler handler) {
  //   super.onError(err, handler);
  // }
}
