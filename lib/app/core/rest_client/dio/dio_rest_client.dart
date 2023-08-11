import 'package:cuida_pet_modular_mobx/app/core/helpers/constants.dart';
import 'package:cuida_pet_modular_mobx/app/core/helpers/environments.dart';
import 'package:cuida_pet_modular_mobx/app/core/local_storage/local_storage.dart';
import 'package:cuida_pet_modular_mobx/app/core/logger/app_logger.dart';
import 'package:cuida_pet_modular_mobx/app/core/rest_client/dio/interceptors/auth_interceptors.dart';
import 'package:cuida_pet_modular_mobx/app/core/rest_client/rest_client.dart';
import 'package:cuida_pet_modular_mobx/app/core/rest_client/rest_client_response.dart';
import 'package:cuida_pet_modular_mobx/app/modules/core/auth/auth_store.dart';
import 'package:dio/dio.dart';

import '../rest_client_exception.dart';

class DioRestClient implements RestClient {
  late final Dio _dio;

  final _defaultOptions = BaseOptions(
    baseUrl: Environments.param(Constants.ENV_BASE_URL_KEY) ?? '',
    connectTimeout: Duration(
        milliseconds: int.parse(
            Environments.param(Constants.REST_CLIENT_CONNECT_TIMEOUT)!)),
    receiveTimeout: Duration(
        milliseconds: int.parse(
            Environments.param(Constants.REST_CLIENT_RECEIVE_TIMEOUT)!)),
  );

  DioRestClient({
    required LocalStorage localStorage,
    required AppLogger log,
    required AuthStore authStore,
    BaseOptions? baseOptions,
  }) {
    _dio = Dio(
      baseOptions ?? _defaultOptions,
    );
    _dio.interceptors.addAll([
      AuthInterceptors(
          localStorage: localStorage, appLogger: log, authStore: authStore),
      LogInterceptor(
        requestBody: true,
        responseBody: true,
      ),
    ]);
  }

  @override
  RestClient auth() {
    _defaultOptions.extra[Constants.REST_CLIENT_AUTH_REQUIRED_KEY] = true;
    return this;
  }

  @override
  RestClient unauth() {
    _defaultOptions.extra[Constants.REST_CLIENT_AUTH_REQUIRED_KEY] = false;
    return this;
  }

  @override
  Future<RestClientResponse<T>> delete<T>(String path,
      {data,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    try {
      final response = await _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );

      return _dioResponseConverte(response);
    } on DioException catch (e) {
      _throwRestClientException(e);
    }
  }

  @override
  Future<RestClientResponse<T>> get<T>(String path,
      {Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );

      return _dioResponseConverte(response);
    } on DioException catch (e) {
      _throwRestClientException(e);
    }
  }

  @override
  Future<RestClientResponse<T>> patch<T>(String path,
      {data,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    try {
      final response = await _dio.patch(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );

      return _dioResponseConverte(response);
    } on DioException catch (e) {
      _throwRestClientException(e);
    }
  }

  @override
  Future<RestClientResponse<T>> post<T>(String path,
      {data,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );

      return _dioResponseConverte(response);
    } on DioException catch (e) {
      _throwRestClientException(e);
    }
  }

  @override
  Future<RestClientResponse<T>> put<T>(String path,
      {data,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    try {
      final response = await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );

      return _dioResponseConverte(response);
    } on DioException catch (e) {
      _throwRestClientException(e);
    }
  }

  @override
  Future<RestClientResponse<T>> request<T>(String path,
      {required String method,
      data,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    try {
      final response = await _dio.request(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers, method: method),
      );

      return _dioResponseConverte(response);
    } on DioException catch (e) {
      _throwRestClientException(e);
    }
  }

  Future<RestClientResponse<T>> _dioResponseConverte<T>(
      Response<dynamic> response) async {
    return RestClientResponse<T>(
        data: response.data,
        statusCode: response.statusCode,
        statusMessage: response.statusMessage);
  }

  Never _throwRestClientException(DioException dioError) {
    final response = dioError.response;
    throw RestClientException(
      error: dioError.error,
      statusCode: response?.statusCode,
      message: response?.statusMessage,
      response: RestClientResponse(
        data: response?.data,
        statusCode: response?.statusCode,
        statusMessage: response?.statusMessage,
      ),
    );
  }
}
