import 'package:money_map/common/models/user_model.dart';
import 'package:money_map/services/auth_service.dart';

class MockAuthService implements AuthService {
  @override
  Future singIn() {
    throw UnimplementedError();
  }

  @override
  Future<UserModel> singUp(
      {String? name, required String email, required String password}) async {
    await Future.delayed(const Duration(seconds: 2));
    try {
      if (password.startsWith('123')) {
        throw Exception();
      }
      return UserModel(
        id: email.hashCode,
        name: name,
        email: email,
      );
    } catch (e) {
      if (password.startsWith('123')) {
        throw 'Senha insegura. Digite uma senha forte!';
      }
      throw 'Não foi possível criar sua conta nesse momento. Tente mais tarde!';
    }
  }
}