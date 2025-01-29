import 'package:flutter/foundation.dart';
import 'package:money_map/features/sign_up/sign_up_state.dart';
import 'package:money_map/services/auth_service.dart';
import 'package:money_map/services/graphql_service.dart';
import 'package:money_map/services/secure_storage.dart';

class SignUpController extends ChangeNotifier {
  final AuthService authService;
  final SecureStorage secureStorage;
  final GraphQlService graphQlService;

  SignUpController({
    required this.authService,
    required this.secureStorage,
    required this.graphQlService,
  });

  SignUpState _state = SignUpInitialState();

  SignUpState get state => _state;

  void _chagneState(SignUpState newState) {
    _state = newState;
    notifyListeners();
  }

  Future<void> signUp({
    String? name,
    required String email,
    required String password,
  }) async {
    _chagneState(SignUpLoadingState());

    try {
      final user = await authService.signUp(
        name: name,
        email: email,
        password: password,
      );

      if (user.id != null) {
        await secureStorage.write(
          key: "CURRENT_USER",
          value: user.toJson(),
        );

        await graphQlService.init();

        _chagneState(SignUpSuccessState());
      } else {
        throw Exception();
      }
    } catch (e) {
      _chagneState(SignUpErrorState(message: e.toString()));
    }
  }
}
