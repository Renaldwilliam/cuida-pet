part of '../login_page.dart';

class _LoginForm extends StatefulWidget {
  const _LoginForm();

  @override
  State<_LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();
  final controller =  Modular.get<LoginController>();

  @override
  void dispose() {
    super.dispose();
    _emailEC.dispose();
    _passwordEC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            CuidaPetTextFormField(
              label: 'Login',
              controller: _emailEC,
              validator: Validatorless.multiple([
                Validatorless.required('E-mail obrigatorio'),
                Validatorless.email('Digite um e-mail valido'),
              ]),
            ),
            const SizedBox(
              height: 20,
            ),
            CuidaPetTextFormField(
              controller: _passwordEC,
              validator: Validatorless.multiple([
                Validatorless.required('Senha obrigatoria'),
                Validatorless.min(6, 'Minimo de carateres é de 6 digitos'),
              ]),
              label: 'Senha',
              obscureText: true,
            ),
            const SizedBox(
              height: 20,
            ),
            CuidaPetDefaultButton(
                onPressed: () async {
                  final formvalid = _formKey.currentState?.validate() ?? false;
                  if (formvalid) {
                    await controller.login(_emailEC.text, _passwordEC.text);
                  }
                  // Loader.show();
                  Mesagens.info('Caguei me todo');
                  // Future.delayed(Duration(seconds: 2), (){
                  //   Loader.hide();
                  // });
                },
                label: 'Entrar'),
          ],
        ));
  }
}
