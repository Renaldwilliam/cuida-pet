import 'package:cuida_pet_modular_mobx/app/core/database/sqlite_connection_factory.dart';
import 'package:cuida_pet_modular_mobx/app/modules/auth/home/auth_home_page.dart';
import 'package:cuida_pet_modular_mobx/app/modules/auth/login/login_modulo.dart';
import 'package:cuida_pet_modular_mobx/app/repositories/user/user_repository.dart';
import 'package:cuida_pet_modular_mobx/app/repositories/user/user_repository_impl.dart';
import 'package:cuida_pet_modular_mobx/app/services/user/user_service.dart';
import 'package:cuida_pet_modular_mobx/app/services/user/user_service_impl.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../repositories/social/social_repository_impl.dart';
import '../core/auth/auth_store.dart';

class AuthModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.lazySingleton((i) => SocialRepositoryImpl()),
        Bind.lazySingleton<UserRepository>(
          (i) => UserRepositoryImpl(
            appLogger: i(),
            restClient: i(),
          ),
        ),
        Bind.lazySingleton<UserService>((i) => UserServiceImpl(
            log: i(),
            userRepository: i(),
            socialRepository: i(),
            localStorage: i(),
            localSecureStorage: i()))
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(Modular.initialRoute,
            child: (_, __) =>
                AuthHomePage(authStore: Modular.get<AuthStore>())),
        ModuleRoute('/login/', module: LoginModulo()),
      ];
}
