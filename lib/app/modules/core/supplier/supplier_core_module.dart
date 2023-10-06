import 'package:cuida_pet_modular_mobx/app/repositories/supplier/supplier_repository.dart';
import 'package:cuida_pet_modular_mobx/app/repositories/supplier/supplier_repository_impl.dart';
import 'package:cuida_pet_modular_mobx/app/services/supplier/supplier_service.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../services/supplier/supplier_service_impl.dart';

class SupplierCoreModule extends Module {

   @override
   List<Bind> get binds => [
    Bind.lazySingleton<SupplierRepository>((i) => SupplierRepositoryImpl(restClient: i(), logger: i()), export: true),
    Bind.lazySingleton<SupplierService>((i) => SupplierServiceImpl(supplierRepository: i()), export: true),
   ];

  //  @override
  //  List<ModularRoute> get routes => [
  //     ChildRoute('/', child: (context, args) => );
  //  ];

}