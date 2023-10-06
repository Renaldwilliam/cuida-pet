import 'package:cuida_pet_modular_mobx/app/entities/address_entity.dart';
import 'package:cuida_pet_modular_mobx/app/models/supplier_category_model.dart';
import 'package:cuida_pet_modular_mobx/app/models/supplier_nearby_me_model.dart';

abstract class SupplierRepository {
  Future<List<SupplierCategoryModel>> getCategories();
  Future<List<SupplierNearbyMeModel>> findNearBy(AddressEntity addressEntity);
}