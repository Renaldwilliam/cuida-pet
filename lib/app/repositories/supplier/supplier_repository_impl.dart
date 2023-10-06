import 'package:cuida_pet_modular_mobx/app/core/exceptions/failure.dart';
import 'package:cuida_pet_modular_mobx/app/core/logger/app_logger.dart';
import 'package:cuida_pet_modular_mobx/app/core/rest_client/rest_client.dart';
import 'package:cuida_pet_modular_mobx/app/core/rest_client/rest_client_exception.dart';
import 'package:cuida_pet_modular_mobx/app/entities/address_entity.dart';
import 'package:cuida_pet_modular_mobx/app/models/supplier_category_model.dart';
import 'package:cuida_pet_modular_mobx/app/models/supplier_nearby_me_model.dart';

import './supplier_repository.dart';

class SupplierRepositoryImpl extends SupplierRepository {
  final RestClient _restClient;
  final AppLogger _log;

  SupplierRepositoryImpl(
      {required RestClient restClient, required AppLogger logger})
      : _restClient = restClient,
        _log = logger;

  @override
  Future<List<SupplierCategoryModel>> getCategories() async {
    try {
      final result = await _restClient.auth().get('/categories/');
      return result.data
          ?.map<SupplierCategoryModel>((categoryResponse) =>
              SupplierCategoryModel.fromMap(categoryResponse))
          .toList();
    } on RestClientException catch (e, s) {
      const message = 'Erro ao buscar categorias dos fornecedores';
      _log.error(message, e, s);
      throw Failure(message: message);
    }
  }

  @override
  Future<List<SupplierNearbyMeModel>> findNearBy(
      AddressEntity addressEntity) async {
    try {
      final result = await _restClient.auth().get(
        '/suppliers/',
        queryParameters: {'lat': addressEntity.lat, 'lng': addressEntity.lng},
      );
      return result.data
          ?.map<SupplierNearbyMeModel>((supplierNerarByMeResponse) =>
              SupplierNearbyMeModel.fromMap(supplierNerarByMeResponse))
          .toList();
    } on RestClientException catch (e, s) {
      const message = 'Erro ao buscar Fornecedores perto de min';
      _log.error(message, e, s);
      throw Failure(message: message);
    }
  }
}
