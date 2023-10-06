import 'package:cuida_pet_modular_mobx/app/modules/home/home_controller.dart';
import 'package:cuida_pet_modular_mobx/app/modules/home/home_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../core/supplier/supplier_core_module.dart';

class HomeModule extends Module {
  @override
  List<Bind> get binds =>
      [Bind.lazySingleton((i) => HomeController(addressService: i(), supplierService: i()))];

  @override
  List<Module> get imports => [SupplierCoreModule()];

  @override
  List<ModularRoute> get routes =>
      [ChildRoute(Modular.initialRoute, child: (_, __) => const HomePage())];
}
