import 'package:cuida_pet_modular_mobx/app/core/life_cycle/page_life_cycle_state.dart';
import 'package:cuida_pet_modular_mobx/app/core/ui/extensions/size_screen_extension.dart';
import 'package:cuida_pet_modular_mobx/app/core/ui/extensions/theme_extension.dart';
import 'package:cuida_pet_modular_mobx/app/entities/address_entity.dart';
import 'package:cuida_pet_modular_mobx/app/models/supplier_category_model.dart';
import 'package:cuida_pet_modular_mobx/app/models/supplier_nearby_me_model.dart';
import 'package:cuida_pet_modular_mobx/app/modules/home/home_controller.dart';
import 'package:cuida_pet_modular_mobx/app/modules/home/widgets/home_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

part 'widgets/home_address_widget.dart';
part 'widgets/home_categories_widget.dart';
part 'widgets/home_supplier_tab.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends PageLifeCycleState<HomeController, HomePage> {
  AddressEntity? addressEntity;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(),
      backgroundColor: Colors.grey[100],
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
             HomeAppBar(controller),
             SliverToBoxAdapter(
              child: _HomeAddressWidget(controller: controller),
            ),
             SliverToBoxAdapter(
              child: _HomeCategoriesWidget(controller),
            ),
          ];
        },
        body: _HomeSupplierTab(homeController: controller),
      ),
    );
  }
}
