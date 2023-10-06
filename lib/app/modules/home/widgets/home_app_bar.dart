// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:cuida_pet_modular_mobx/app/core/ui/extensions/size_screen_extension.dart';
import 'package:cuida_pet_modular_mobx/app/core/ui/extensions/theme_extension.dart';
import 'package:cuida_pet_modular_mobx/app/modules/home/home_controller.dart';

class HomeAppBar extends SliverAppBar {
  HomeAppBar(HomeController controller, {super.key})
      : super(
          expandedHeight: 100,
          collapsedHeight: 100,
          elevation: 0,
          flexibleSpace: _CuidapetAppBar(controller),
          iconTheme: const IconThemeData(color: Colors.black), 
          pinned: true,
        );
}

class _CuidapetAppBar extends StatelessWidget {
  HomeController controller;
  _CuidapetAppBar(this.controller);

  @override
  Widget build(BuildContext context) {
    final outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide(color: Colors.grey[200]!),
    );
    return AppBar(
      backgroundColor: Colors.grey[100],
      centerTitle: true,
      title: const Padding(
        padding: EdgeInsets.only(bottom: 12.0),
        child: Text('CuidaPet'),
      ),
      actions: [
        IconButton(
          onPressed: () {
            controller.goToAdressPage();
          },
          icon: const Icon(
            Icons.location_on,
            color: Colors.black,
          ),
        ),
      ],
      elevation: 0,
      flexibleSpace: Stack(
        children: [
          Container(
            height: 110.h,
            color: context.primaryColor,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: .9.sw,
              child: Material(
                borderRadius: BorderRadius.circular(30),
                elevation: 4,
                child: TextFormField(
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    suffixIcon: const Icon(
                      Icons.search,
                      color: Colors.grey,
                      size: 25,
                    ),
                    border: outlineInputBorder,
                    focusedBorder: outlineInputBorder,
                    enabledBorder: outlineInputBorder,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
