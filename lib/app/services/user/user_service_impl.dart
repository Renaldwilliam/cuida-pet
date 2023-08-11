// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cuida_pet_modular_mobx/app/core/exceptions/failure.dart';
import 'package:cuida_pet_modular_mobx/app/core/exceptions/user_exists_exception.dart';
import 'package:cuida_pet_modular_mobx/app/core/exceptions/user_not_exists_exception.dart';
import 'package:cuida_pet_modular_mobx/app/core/local_storage/local_storage.dart';
import 'package:cuida_pet_modular_mobx/app/core/logger/app_logger.dart';
import 'package:cuida_pet_modular_mobx/app/models/social_login_type.dart';
import 'package:cuida_pet_modular_mobx/app/models/social_network_model.dart';
import 'package:cuida_pet_modular_mobx/app/repositories/social/social_repository.dart';
import 'package:cuida_pet_modular_mobx/app/repositories/user/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../core/helpers/constants.dart';
import 'user_service.dart';

class UserServiceImpl implements UserService {
  final AppLogger _log;
  final UserRepository _userRepository;
  final LocalStorage _localStorage;
  final LocalSecureStorage _localSecureStorage;
  final SocialRepository _socialRepository;
  UserServiceImpl(
      {required AppLogger log,
      required UserRepository userRepository,
      required SocialRepository socialRepository,
      required LocalSecureStorage localSecureStorage,
      required LocalStorage localStorage})
      : _log = log,
        _userRepository = userRepository,
        _socialRepository = socialRepository,
        _localSecureStorage = localSecureStorage,
        _localStorage = localStorage;

  @override
  Future<void> register(String email, String password) async {
    try {
      final firebaseAuth = FirebaseAuth.instance;

      final userLoggerdMethods =
          await firebaseAuth.fetchSignInMethodsForEmail(email);
      if (userLoggerdMethods.isNotEmpty) {
        throw UserExistsException();
      }

      await _userRepository.register(email, password);
      final userRegisterCredital = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      await userRegisterCredital.user?.sendEmailVerification();
    } on FirebaseException catch (e, s) {
      _log.error("Erro ao criar usuario no Firebase", e, s);
      throw Failure(message: 'Erro ao criar usuario');
    }
  }

  @override
  Future<void> loginWithEmailPassword(String email, String password) async {
    try {
      final firebaseAuth = FirebaseAuth.instance;
      final loginMethods = await firebaseAuth.fetchSignInMethodsForEmail(email);

      if (loginMethods.isEmpty) {
        throw UserNotExistsException();
      }

      if (loginMethods.contains('password')) {
        final userCredital = await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);

        final userVerified = userCredital.user?.emailVerified ?? false;

        if (!userVerified) {
          userCredital.user?.sendEmailVerification();
          throw Failure(
              message:
                  'E-mail não confirmado, por favor verifique sua caixa de span');
        }
        final accessToken =
            await _userRepository.loginWithEmailPassword(email, password);

        await _saveAccessToken(accessToken);
        await _confirmLogin();
        await _getUserData();
        // final token = await _localStorage.read<String>(Constants.LOCAL_STORAGE_ACCESS_TOKEN_KEY);
      } else {
        throw Failure(
            message:
                'Login não pode ser feito por e-mail e senha, por favor utilize outro metodo');
      }
    } on FirebaseAuthException catch (e, s) {
      _log.error(
          'Usuario ou senha inválidos FirebaseAuthException[${e.code}]', e, s);
      throw Failure(message: 'Usuário ou senha invalidos');
    }
  }

  Future<void> _saveAccessToken(String accessToken) async => await _localStorage
      .write(Constants.LOCAL_STORAGE_ACCESS_TOKEN_KEY, accessToken);

  Future<void> _confirmLogin() async {
    final confirmLoginModel = await _userRepository.confirmLogin();
    await _saveAccessToken(confirmLoginModel.accessToken);
    await _localSecureStorage.write(
        Constants.LOCAL_STORAGE_REFRESH_ACCESS_TOKEN_KEY,
        confirmLoginModel.refreshToken);
  }

  Future<void> _getUserData() async {
    final userModel = await _userRepository.getUserLogged();
    await _localStorage.write<String>(
        Constants.LOCAL_STORAGE_USER_LOGGED_DATA_KEY, userModel.toJson());
  }

  @override
  Future<void> socialLogin(SocialLoginType socialLoginType) async {
    try {
      final SocialNetworkModel socialModel;
      final AuthCredential authCredential;
      final firebaseAuth = FirebaseAuth.instance;
      switch (socialLoginType) {
        case SocialLoginType.facebook:
          throw Failure(message: 'Facebook not implemeted');
        // break;
        case SocialLoginType.google:
          socialModel = await _socialRepository.googleLogin();
          authCredential = GoogleAuthProvider.credential(
              accessToken: socialModel.accessToken, idToken: socialModel.id);
          break;
      }

      final loginMethods =
          await firebaseAuth.fetchSignInMethodsForEmail(socialModel.email);

      final methodCheck = _getMethodSocialLoginType(socialLoginType);

      if (loginMethods.isNotEmpty && !loginMethods.contains(methodCheck)) {
        throw Failure(
            message:
                'Login não pode ser feito por $methodCheck, por favor utilize outro metodo');
      }

      await firebaseAuth.signInWithCredential(authCredential);
      final accessToken = await _userRepository.loginSocial(socialModel);
      await _saveAccessToken(accessToken);
      await _confirmLogin();
      await _getUserData();
    } on FirebaseAuthException catch (e,s) {
      _log.error('Erro ao realizar login com $socialLoginType', e ,s);
      throw Failure(message: 'Erro ao realizar login');

    }
  }

  String? _getMethodSocialLoginType(SocialLoginType socialLoginType) {
    switch (socialLoginType) {
      case SocialLoginType.facebook:
        return 'facebook.com';
      case SocialLoginType.google:
        return 'google.com';
      default:
    }
    return null;
  }
}
