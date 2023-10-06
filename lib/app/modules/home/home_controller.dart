import 'package:cuida_pet_modular_mobx/app/core/ui/widgets/mesagens.dart';
import 'package:cuida_pet_modular_mobx/app/entities/address_entity.dart';
import 'package:cuida_pet_modular_mobx/app/models/supplier_category_model.dart';
import 'package:cuida_pet_modular_mobx/app/models/supplier_nearby_me_model.dart';
import 'package:cuida_pet_modular_mobx/app/services/address/address_service.dart';
import 'package:cuida_pet_modular_mobx/app/services/supplier/supplier_service.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../core/life_cycle/controller_life_cycle.dart';
import '../../core/ui/widgets/loader.dart';
part 'home_controller.g.dart';

enum SupplierPageType { list, grid }

class HomeController = HomeControllerBase with _$HomeController;

abstract class HomeControllerBase with Store, ControllerLifeCycle {
  final AddressService _addressService;
  final SupplierService _supplierService;

  @readonly
  AddressEntity? _addressEntity;

  @readonly
  var _listCategories = <SupplierCategoryModel>[];

  @readonly
  var _listSuppliersByAddress = <SupplierNearbyMeModel>[];

  @readonly
  var _supplierPageTypeSelected = SupplierPageType.list;

  late ReactionDisposer findSupplierReactionDisposer;

  HomeControllerBase(
      {required AddressService addressService,
      required SupplierService supplierService})
      : _addressService = addressService,
        _supplierService = supplierService;

  @override
  void onInit([Map<String, dynamic>? params]) {
    super.onInit(params);
    findSupplierReactionDisposer = reaction((_) => _addressEntity, (address) { 
      _findSupplierByAddress();
    });

  }

  @override
  void dispose() {
    findSupplierReactionDisposer();
    super.dispose();
  }

  @override
  Future<void> onReady() async {
    try {
      Loader.show();
      await _getAddressSelected();
      await _getCategpries();
    } finally {
      Loader.hide();
    }
  }

  @action
  Future<void> _getAddressSelected() async {
    _addressEntity ??= await _addressService.getAddressSelected();
    if (_addressEntity == null) {
      await goToAdressPage();
    }
  }

  @action
  Future<void> goToAdressPage() async {
    final address = await Modular.to.pushNamed<AddressEntity>('/address/');
    if (address != null) {
      _addressEntity = address;
    }
  }

  @action
  Future<void> _getCategpries() async {
    try {
      final categories = await _supplierService.getCategories();
      _listCategories = [...categories];
    } catch (e) {
      Mesagens.alert("Erro ao buscar as Categorias");
      throw Exception();
    }
  }

  @action
  Future<void> _findSupplierByAddress() async {
    try {
     if (_addressEntity != null) {
       final suppliers = await _supplierService.findNearBy(_addressEntity!);
       _listSuppliersByAddress = [...suppliers];
     }else {
      Mesagens.alert("para realizar a buscar de petShops vocês precisa selecione um endereço");
     }
    } catch (e) {
      Mesagens.alert("Erro ao buscar as Categorias");
      throw Exception();
    }
  }

  @action
  void changeTabSupplier(SupplierPageType supplierPageType) {
    _supplierPageTypeSelected = supplierPageType;
  }

}
