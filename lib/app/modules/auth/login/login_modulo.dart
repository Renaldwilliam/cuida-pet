import 'package:cuida_pet_modular_mobx/app/modules/auth/login/login_controller.dart';
import 'package:cuida_pet_modular_mobx/app/modules/auth/login/login_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LoginModulo extends Module {
  @override
  List<Bind> get binds => [
        Bind.lazySingleton(
          (i) => LoginController(userService: i(), log: i()),
        )
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          Modular.initialRoute,
          child: (_, __) => const LoginPage(),
        ),
      ];
}
