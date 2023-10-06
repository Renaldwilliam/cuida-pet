import 'package:cuida_pet_modular_mobx/app/core/helpers/environments.dart';
import 'package:cuida_pet_modular_mobx/app/core/ui/extensions/size_screen_extension.dart';
import 'package:cuida_pet_modular_mobx/app/core/ui/extensions/theme_extension.dart';
import 'package:cuida_pet_modular_mobx/app/core/ui/icons/cuidapet_icons.dart';
import 'package:cuida_pet_modular_mobx/app/core/ui/widgets/cuida_pet_default_button.dart';
import 'package:cuida_pet_modular_mobx/app/core/ui/widgets/cuida_pet_text_form_field.dart';
import 'package:cuida_pet_modular_mobx/app/core/ui/widgets/mesagens.dart';
import 'package:cuida_pet_modular_mobx/app/models/social_login_type.dart';
import 'package:cuida_pet_modular_mobx/app/modules/auth/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:validatorless/validatorless.dart';

import '../../../core/ui/widgets/rounded_butoon_with_icon.dart';

part 'widgets/login_form.dart';
part 'widgets/login_register_buttons.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            SizedBox(
              height: 50.h,
            ),
            Text(Environments.param('base_url') ?? ''),
            Center(
              child: Image.asset(
                'assets/images/logo.png',
                width: 162.w,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            const _LoginForm(),
            SizedBox(
              height: 8.h,
            ),
            const _OrSeparator(),
            SizedBox(
              height: 8.h,
            ),
            _LoginRegisterButtons()
          ],
        ),
      ),
    ));
  }
}

class _OrSeparator extends StatelessWidget {
  const _OrSeparator();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            thickness: 1,
            color: context.primaryColor,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'OU',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.sp,
                color: context.primaryColor),
          ),
        ),
        Expanded(
          child: Divider(
            thickness: 1,
            color: context.primaryColor,
          ),
        ),
      ],
    );
  }
}
