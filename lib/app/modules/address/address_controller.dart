import 'dart:ffi';

import 'package:cuida_pet_modular_mobx/app/core/life_cycle/controller_life_cycle.dart';
import 'package:cuida_pet_modular_mobx/app/core/ui/widgets/mesagens.dart';
import 'package:cuida_pet_modular_mobx/app/entities/address_entity.dart';
import 'package:cuida_pet_modular_mobx/app/models/place_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mobx/mobx.dart';

import '../../core/ui/widgets/loader.dart';
import '../../services/address/address_service.dart';
part 'address_controller.g.dart';

class AddressController = AddressControllerBase with _$AddressController;

abstract class AddressControllerBase with Store, ControllerLifeCycle {
  final AddressService _addressService;

  @readonly
  var _adressses = <AddressEntity>[];

  @readonly
  var _locationServiceUnavailable = false;

  @readonly
  LocationPermission? _locationPermission;

  @readonly
  PlaceModel? _placeModel;

  AddressControllerBase({required AddressService addressService})
      : _addressService = addressService;

  @override
  void onReady() {
    _getAddresses();
  }

  @action
  Future<void> _getAddresses() async {
    Loader.show();
    _adressses = await _addressService.getAddress();
    Loader.hide();
  }

  @action
  Future<void> myLocation() async {
    _locationPermission = null;
    _locationServiceUnavailable = false;
    final serviceEnable = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnable) {
      _locationServiceUnavailable = true;
      return;
    }

    final locationPermission = await Geolocator.checkPermission();

    switch (locationPermission) {
      case LocationPermission.denied:
        final permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied ||
            permission == LocationPermission.deniedForever) {
          _locationPermission = permission;
          return;
        }

        break;
      case LocationPermission.deniedForever:
        _locationPermission = locationPermission;
        return;
      case LocationPermission.whileInUse:
      case LocationPermission.always:
      case LocationPermission.unableToDetermine:
        break;
    }

    Loader.show();
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    final placemark =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    final place = placemark.first;
    final address = '${place.thoroughfare} ${place.subThoroughfare}';
    final placeModel = PlaceModel(
      address: address,
      lat: position.latitude,
      log: position.longitude,
    );
    Loader.hide();
    goToAddressDetail(placeModel);
  }

  Future<void> goToAddressDetail(PlaceModel place) async {
    final address =
        await Modular.to.pushNamed('/address/detail/', arguments: place);
    if (address is PlaceModel) {
      _placeModel = address;
    } else if (address is AddressEntity) {
      selectAddress(address);
    }
  }

  Future<void> selectAddress(AddressEntity addressEntity) async {
    await _addressService.selectAddress(addressEntity);
    Modular.to.pop(addressEntity);
  }

  Future<bool> addressWasSelected() async {
    final address = await _addressService.getAddressSelected();

    if (address != null) {
      return true;
    } else {
      Mesagens.alert('Por favor selecione ou cadastre um endereço');
      return false;
    }
  }
}
