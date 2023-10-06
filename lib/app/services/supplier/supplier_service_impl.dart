import '../../models/supplier_category_model.dart';
import '../../models/supplier_nearby_me_model.dart';
import '../../repositories/supplier/supplier_repository.dart';

import '../../entities/address_entity.dart';
import 'supplier_service.dart';

class SupplierServiceImpl extends SupplierService {
  final SupplierRepository _supplierRepository;

  SupplierServiceImpl({required SupplierRepository supplierRepository})
      : _supplierRepository = supplierRepository;

  @override
  Future<List<SupplierCategoryModel>> getCategories() =>
      _supplierRepository.getCategories();

  @override
  Future<List<SupplierNearbyMeModel>> findNearBy(AddressEntity addressEntity) =>
      _supplierRepository.findNearBy(addressEntity);
}
