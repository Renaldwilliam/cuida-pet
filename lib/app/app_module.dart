import 'package:cuida_pet_modular_mobx/app/modules/address/address_module.dart';
import 'package:cuida_pet_modular_mobx/app/modules/auth/auth_module.dart';
import 'package:cuida_pet_modular_mobx/app/modules/auth/register/register_modulo.dart';
import 'package:cuida_pet_modular_mobx/app/modules/core/core_module.dart';
import 'package:cuida_pet_modular_mobx/app/modules/home/home_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute('/auth/', module: AuthModule()),
        ModuleRoute('/home/', module: HomeModule()),
        ModuleRoute('/auth/register/', module: RegisterModulo()),
        ModuleRoute('/address', module: AddressModule())
      ];

  @override
  List<Module> get imports => [CoreModule()];
}
