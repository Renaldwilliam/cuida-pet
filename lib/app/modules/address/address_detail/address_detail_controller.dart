import 'package:cuida_pet_modular_mobx/app/entities/address_entity.dart';
import 'package:cuida_pet_modular_mobx/app/models/place_model.dart';
import 'package:cuida_pet_modular_mobx/app/services/address/address_service.dart';
import 'package:mobx/mobx.dart';

import '../../../core/ui/widgets/loader.dart';
part 'address_detail_controller.g.dart';

class AddressDetailController = AddressDetailControllerBase
    with _$AddressDetailController;

abstract class AddressDetailControllerBase with Store {
  final AddressService _addressService;

  @readonly
  AddressEntity? _addressEntity;

  AddressDetailControllerBase({required AddressService addressService})
      : _addressService = addressService;

  

  Future<void> saveAddress(PlaceModel placeModel, String additional) async {
    Loader.show();
    final addressEntity = await _addressService.saveAddress(placeModel, additional);
    Loader.hide();
    _addressEntity = addressEntity;

  }
}
