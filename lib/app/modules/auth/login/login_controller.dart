import 'package:cuida_pet_modular_mobx/app/core/exceptions/failure.dart';
import 'package:cuida_pet_modular_mobx/app/core/exceptions/user_not_exists_exception.dart';
import 'package:cuida_pet_modular_mobx/app/core/logger/app_logger.dart';
import 'package:cuida_pet_modular_mobx/app/core/ui/widgets/loader.dart';
import 'package:cuida_pet_modular_mobx/app/core/ui/widgets/mesagens.dart';
import 'package:cuida_pet_modular_mobx/app/models/social_login_type.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../../services/user/user_service.dart';
part 'login_controller.g.dart';

class LoginController = LoginControllerBase with _$LoginController;

abstract class LoginControllerBase with Store {
  final UserService _userService;
  final AppLogger _log;

  LoginControllerBase({
    required UserService userService,
    required AppLogger log,
  })  : _userService = userService,
        _log = log;

  Future<void> login(String email, String password) async {
    try {
      Loader.show();
      await _userService.loginWithEmailPassword(email, password);
      Loader.hide();
      Modular.to.navigate('/auth/');
    } on Failure catch (e, s) {
      final erroMessagem = e.message ?? 'Erro ao realizar login';
      _log.error(erroMessagem, e, s);
      Loader.hide();
      Mesagens.alert(erroMessagem);
    } on UserNotExistsException {
      const erroMessagem = 'Usuario não cadastrado';
      _log.error(erroMessagem);
      Loader.hide();
      Mesagens.alert(erroMessagem);
    }
  }

  Future<void> sociaLogin(SocialLoginType socialLoginType) async {
    try {
      Loader.show();
      await _userService.socialLogin(socialLoginType);
      Loader.hide();
      Modular.to.navigate('/auth/');
    } on Failure catch (e, s) {
      Loader.hide();
      _log.error('Erro ao fazer logim', e, s);
      Mesagens.alert(e.message ?? 'Erro ao realizar loggin');
    }
  }
}
