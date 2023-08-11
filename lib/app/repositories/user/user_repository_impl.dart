// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:cuida_pet_modular_mobx/app/core/exceptions/user_exists_exception.dart';
import 'package:cuida_pet_modular_mobx/app/core/logger/app_logger.dart';
import 'package:cuida_pet_modular_mobx/app/core/rest_client/rest_client.dart';
import 'package:cuida_pet_modular_mobx/app/core/rest_client/rest_client_exception.dart';
import 'package:cuida_pet_modular_mobx/app/models/confirm_login_model.dart';
import 'package:cuida_pet_modular_mobx/app/models/social_network_model.dart';
import 'package:cuida_pet_modular_mobx/app/models/user_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../core/exceptions/failure.dart';
import './user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final RestClient _restClient;
  final AppLogger _appLogger;
  UserRepositoryImpl({
    required RestClient restClient,
    required AppLogger appLogger,
  })  : _restClient = restClient,
        _appLogger = appLogger;

  @override
  Future<void> register(String email, String password) async {
    try {
      await _restClient
          .unauth()
          .post('/auth/register', data: {'email': email, 'password': password});
    } on RestClientException catch (e, s) {
      if (e.statusCode == 400 &&
          e.response.data['message']
              .contains('Usuário já cadastrado na base de dados')) {
        _appLogger.error(e.error, s);
        throw UserExistsException();
      }
      _appLogger.error('Erro ao cadastrar usuário', e, s);
      throw Failure(message: 'Erro ao cadastrar usuário');
    }
  }

  @override
  Future<String> loginWithEmailPassword(String email, String password) async {
    try {
      final result = await _restClient.unauth().post(
        '/auth/',
        data: {
          "login": email,
          "password": password,
          "social_login": false,
          "supplier_user": false
        },
      );

      return result.data['access_token'];
    } on RestClientException catch (e, s) {
      if (e.statusCode == 403) {
        throw Failure(
            message: 'Usuário inconsistente, entre em contato com suporte');
      }
      _appLogger.error('Erro ao realizar login', e, s);
      throw Failure(
          message: 'Erro ao realizar login, tente novamente mais tarde');
    }
  }

  @override
  Future<ConfirmLoginModel> confirmLogin() async {
    try {
      final deviceToken = await FirebaseMessaging.instance.getToken();
      final result = await _restClient.auth().patch('/auth/confirm', data: {
        'ios_token': Platform.isIOS ? deviceToken : null,
        'android_token': Platform.isAndroid ? deviceToken : null,
      });

      return ConfirmLoginModel.fromMap(result.data);
    } on RestClientException catch (e, s) {
      _appLogger.error('Erro ao confirma login', e, s);
      throw Failure(message: 'Erro ao confirmar login');
    }
  }

  @override
  Future<UserModel> getUserLogged() async {
    try {
      final result = await _restClient.get('/user/');
      return UserModel.fromMap(result.data);
    } on RestClientException catch (e, s) {
      _appLogger.error('Erro ao buscar dados do usário logado', e, s);
      throw Failure(message: 'Erro ao buscar dados do usário logado');
    }
  }

  @override
  Future<String> loginSocial(SocialNetworkModel model) async {
    try {
      final result = await _restClient.unauth().post('/auth', data: {
        "login": model.email,
        "social_login": true,
        "avatar": model.avatar,
        "social_type": model.type,
        "social_key": model.id,
        "supplier_user": false
      });

      return result.data['access_token'];
    } on RestClientException catch (e, s) {
      if (e.statusCode == 403) {
        throw Failure(
            message: 'Usuário inconsistente, entre em contato com suporte');
      }
      _appLogger.error('Erro ao realizar login', e, s);
      throw Failure(
          message: 'Erro ao realizar login, tente novamente mais tarde');
    }
  }
}
