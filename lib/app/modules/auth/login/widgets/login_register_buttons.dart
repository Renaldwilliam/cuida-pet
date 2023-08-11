part of '../login_page.dart';

class _LoginRegisterButtons extends StatelessWidget {

  final LoginController controller = Modular.get<LoginController>();
  
  _LoginRegisterButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.horizontal,
      alignment: WrapAlignment.center,
      spacing: 10,
      runSpacing: 10,
      children: [
        RoundedButoonWithIcon(
          onTap: () {},
          color: const Color(0xFF3B5999),
          width: .42.sw,
          label: 'Facebook',
          icon: CuidapetIcons.facebook,
        ),
        RoundedButoonWithIcon(
          onTap: () {
            controller.sociaLogin(SocialLoginType.google);
          },
          color: const Color(0xFFEE5C2E),
          width: .42.sw,
          label: 'Google',
          icon: CuidapetIcons.google,
        ),
        RoundedButoonWithIcon(
          onTap: () {
            Navigator.pushNamed(context, '/auth/register/');
          },
          color: const Color(0xFF689F38),
          width: .42.sw,
          label: 'Cadastre-se',
          icon: Icons.mail,
        ),
      ],
    );
  }
}
