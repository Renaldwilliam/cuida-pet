import 'package:cuida_pet_modular_mobx/app/core/ui/extensions/size_screen_extension.dart';
import 'package:cuida_pet_modular_mobx/app/core/ui/widgets/cuida_pet_default_button.dart';
import 'package:cuida_pet_modular_mobx/app/core/ui/widgets/cuida_pet_text_form_field.dart';
import 'package:cuida_pet_modular_mobx/app/modules/auth/register/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:validatorless/validatorless.dart';

part 'widgets/register_form.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro usuário'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 50.h,
            ),
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
            _RegisterForm(),
          ],
        ),
      ),
    );
  }
}
