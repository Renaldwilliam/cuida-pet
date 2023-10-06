import 'package:cuida_pet_modular_mobx/app/models/place_model.dart';
import 'package:cuida_pet_modular_mobx/app/services/address/address_service.dart';
import 'package:mobx/mobx.dart';

part 'address_search_controller.g.dart';

class AddressSearchController = AddressSearchControllerBase with _$AddressSearchController;

abstract class AddressSearchControllerBase with Store {
  final AddressService _addressService;

  AddressSearchControllerBase({ required AddressService addressService}) : _addressService = addressService;


  Future<List<PlaceModel>> searchAddress(String addressPattern) => _addressService.findAddressByGooglePlaces(addressPattern);

}