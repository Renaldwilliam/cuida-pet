import 'package:cuida_pet_modular_mobx/app/modules/auth/register/register_controller.dart';
import 'package:cuida_pet_modular_mobx/app/modules/auth/register/register_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class RegisterModulo extends Module {
  @override
  List<Bind> get binds => [
        Bind.lazySingleton<RegisterController>(
            (i) => RegisterController(log: i(), userService: i())),
      ];
  @override
  List<ModularRoute> get routes =>
      [ChildRoute(Modular.initialRoute, child: (_, __) => const RegisterPage())];
}
