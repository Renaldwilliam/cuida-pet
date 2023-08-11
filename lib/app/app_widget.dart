import 'package:asuka/asuka.dart';
import 'package:cuida_pet_modular_mobx/app/core/ui/ui_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Modular.setObservers([Asuka.asukaHeroController]);
    Modular.setInitialRoute('/auth/');
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (context, child) => MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: UiConfig.title,
        builder: Asuka.builder,
        theme: UiConfig.theme,
        routeInformationParser: Modular.routeInformationParser,
        routerDelegate: Modular.routerDelegate,
        // routeInformationParser: Modular.routeInformationParser,
        // routerDelegate: Modular.routerDelegate,
      ),
    ); //added by extension
  }
}
