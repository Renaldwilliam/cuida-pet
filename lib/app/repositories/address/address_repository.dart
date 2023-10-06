import 'package:cuida_pet_modular_mobx/app/models/place_model.dart';

import '../../entities/address_entity.dart';

abstract class AddressRepository {
  Future<List<PlaceModel>> findAddressByGooglePlaces(String address);
  Future<List<AddressEntity>> getAddress();
  Future<int> saveAddress(AddressEntity entity);
  Future<void> deleteAll();
}