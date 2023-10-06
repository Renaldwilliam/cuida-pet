import 'dart:async';
import 'package:cuida_pet_modular_mobx/app/core/life_cycle/page_life_cycle_state.dart';
import 'package:cuida_pet_modular_mobx/app/core/ui/extensions/theme_extension.dart';
import 'package:cuida_pet_modular_mobx/app/models/place_model.dart';
import 'package:cuida_pet_modular_mobx/app/modules/address/address_controller.dart';
import 'package:cuida_pet_modular_mobx/app/modules/address/widgets/address_search_widget/address_search_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mobx/mobx.dart';

import '../../core/mixins/location_mixin.dart';
part 'widgets/address_item.dart';
part 'widgets/address_search_widget/address_search_widget.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({super.key});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState
    extends PageLifeCycleState<AddressController, AddressPage>
    with LocationMixin {
  final reactionDisposers = <ReactionDisposer>[];

  @override
  void initState() {
    super.initState();
    final reactionService =
        reaction<bool>((_) => controller.locationServiceUnavailable,
            (locationServiceUnavailable) {
      if (locationServiceUnavailable) {
        showDialogLocationServiceUnavailable();
      }
    });

    final reactionLocationPermission = reaction<LocationPermission?>(
        (_) => controller.locationPermission, (locationPermission) {
      if (locationPermission != null &&
          locationPermission == LocationPermission.denied) {
        showDialogLocationServiceDenied(
            tryAgain: () => controller.myLocation());
      } else if (locationPermission != null &&
          locationPermission == LocationPermission.deniedForever) {
        showDialogLocationServiceDeniedForever();
      }
    });

    reactionDisposers.addAll([reactionService, reactionLocationPermission]);
  }

  @override
  void dispose() {
    super.dispose();
    for (var reaction in reactionDisposers) {
      reaction();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => controller.addressWasSelected(),
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: context.primaryColorDark),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(13.0),
            child: Column(
              children: [
                Text(
                  'Adicione ou escolha um endereço',
                  style: context.textTheme.headlineMedium?.copyWith(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                Observer(
                  builder: (_) {
                    return _AddressSearchWidget(
                      key: UniqueKey(),
                      addressSelectedCallback: (place) {
                        controller.goToAddressDetail(place);
                        // Modular.to.pushNamed('/address/detail/', arguments: place);
                      },
                      place: controller.placeModel,
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                ListTile(
                  onTap: () => controller.myLocation(),
                  leading: const CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: 30,
                    child: Icon(
                      Icons.near_me,
                      color: Colors.white,
                    ),
                  ),
                  title: const Text(
                    'Localização atual',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                ),
                Observer(
                  builder: (_) {
                    return Column(
                      children: controller.adressses
                          .map((a) => _AddressItem(
                              address: a.address,
                              additional: a.addtional,
                              onTap: () {
                                controller.selectAddress(a);
                              }))
                          .toList(),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
