part of '../register_page.dart';

class _RegisterForm extends StatefulWidget {
  const _RegisterForm({super.key});

  @override
  State<_RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<_RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _loginEC = TextEditingController();
  final _passwordEC = TextEditingController();
  final _controller = Modular.get<RegisterController>();

  @override
  void dispose() {
    super.dispose();
    _loginEC.dispose();
    _passwordEC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              CuidaPetTextFormField(
                label: 'Login',
                controller: _loginEC,
                validator: Validatorless.multiple([
                  Validatorless.required('Login obrigatório'),
                  Validatorless.email('Login deve ser um e-mail válido'),
                ]),
              ),
              const SizedBox(
                height: 20,
              ),
              CuidaPetTextFormField(
                label: 'Senha',
                controller: _passwordEC,
                obscureText: true,
                validator: Validatorless.multiple([
                  Validatorless.required('Senha obrigatório'),
                  Validatorless.min(
                      6, 'Senha precisa ter pelo menos 6 caracteres'),
                ]),
              ),
              const SizedBox(
                height: 20,
              ),
              CuidaPetTextFormField(
                label: 'Confirma Senha',
                obscureText: true,
                validator: Validatorless.multiple([
                  Validatorless.required('Confirma  Senha obrigatório'),
                  Validatorless.min(
                      6, 'Senha precisa ter pelo menos 6 caracteres'),
                  Validatorless.compare(
                      _passwordEC, 'Senha e confirma senha não são iguais'),
                ]),
              ),
              const SizedBox(
                height: 20,
              ),
              CuidaPetDefaultButton(
                  onPressed: () {
                    final formValid =
                        _formKey.currentState?.validate() ?? false;

                    if (formValid) {
                      _controller.register(
                          email: _loginEC.text, password: _passwordEC.text);
                    }
                  },
                  label: 'Cadastrar'),
            ],
          ),
        ));
  }
}
