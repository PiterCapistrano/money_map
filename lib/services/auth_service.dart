import 'package:money_map/common/models/user_model.dart';

abstract class AuthService {
  Future<UserModel> singUp({
    String? name,
    required String email,
    required String password,
  });
  Future singIn();
}
