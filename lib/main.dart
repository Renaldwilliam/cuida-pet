import 'package:cuida_pet_modular_mobx/app/app_module.dart';
import 'package:cuida_pet_modular_mobx/app/core/application_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'app/app_widget.dart';

Future<void> main() async { 
  await ApplicationConfig().configureApp();
  runApp(
    ModularApp(
      module: AppModule(),
      child: const AppWidget(),
    ),
  );
}
