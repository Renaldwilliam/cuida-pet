import 'package:cuida_pet_modular_mobx/app/modules/home/home_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeModule extends Module {
  // @override
  // List<Bind> get binds => [

  // ];

  // @override
  // void routes(r) {
  //   r.child(
  //     Modular.initialRoute,
  //     child: (context) => LoginPage(),
  //   );
  // }

  @override
  List<ModularRoute> get routes => [
        ChildRoute(Modular.initialRoute, child: (_, __) => HomePage()),
      ];
}
