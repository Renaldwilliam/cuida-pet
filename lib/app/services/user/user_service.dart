import 'package:cuida_pet_modular_mobx/app/models/social_login_type.dart';

abstract class UserService {
  Future<void> register(String email, String password);
  Future<void> loginWithEmailPassword(String email, String password);
  Future<void> socialLogin(SocialLoginType socialLoginType);
}