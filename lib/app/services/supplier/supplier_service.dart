import 'package:cuida_pet_modular_mobx/app/models/supplier_category_model.dart';

import '../../entities/address_entity.dart';
import '../../models/supplier_nearby_me_model.dart';


abstract class SupplierService {
  Future<List<SupplierCategoryModel>> getCategories();
  Future<List<SupplierNearbyMeModel>> findNearBy(AddressEntity addressEntity);

}