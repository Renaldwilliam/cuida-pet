// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cuida_pet_modular_mobx/app/core/exceptions/user_exists_exception.dart';
import 'package:cuida_pet_modular_mobx/app/core/ui/widgets/loader.dart';
import 'package:cuida_pet_modular_mobx/app/core/ui/widgets/mesagens.dart';
import 'package:mobx/mobx.dart';

import 'package:cuida_pet_modular_mobx/app/core/logger/app_logger.dart';
import 'package:cuida_pet_modular_mobx/app/services/user/user_service.dart';

part 'register_controller.g.dart';

class RegisterController = RegisterControllerBase with _$RegisterController;

abstract class RegisterControllerBase with Store {
  final AppLogger _log;
  final UserService _userService;

  RegisterControllerBase({
    required AppLogger log,
    required UserService userService,
  })  : _log = log,
        _userService = userService;

  Future<void> register(
      {required String email, required String password}) async {
    try {
      Loader.show();
      await _userService.register(email, password);
      Mesagens.info('Enviamos um e-mail de confirmação,por favor olhe sua caixa de e-mail');
      Loader.hide();
    } on UserExistsException {
      Loader.hide();
      Mesagens.alert('E-mail já utilizado, por favor escolha outro e-mail');
    } catch(e ,s){
      _log.error('Erro ao registar usuário', e ,s);
      Loader.hide();
      Mesagens.alert('Erro ao registrar usuário');
    }

  }
}
