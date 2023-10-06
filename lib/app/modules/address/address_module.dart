import 'package:cuida_pet_modular_mobx/app/modules/address/address_controller.dart';
import 'package:cuida_pet_modular_mobx/app/modules/address/address_detail/address_detail_module.dart';
import 'package:cuida_pet_modular_mobx/app/modules/address/widgets/address_search_widget/address_search_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'address_page.dart';

class AddressModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.lazySingleton(
            (i) => AddressSearchController(addressService: i())), // core module
        Bind.lazySingleton(
            (i) => AddressController(addressService: i())) // core module
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(Modular.initialRoute,
            child: (context, args) => const AddressPage()),
        ModuleRoute('/detail', module: AddressDetailModule())
      ];
}
