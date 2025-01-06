import 'package:flutter/foundation.dart';
import 'package:money_map/features/sign_up/sign_up_state.dart';
import 'package:money_map/services/auth_service.dart';

class SignUpController extends ChangeNotifier {
  final AuthService _service;

  SignUpController(this._service);

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
      await _service.signUp(
        name: name,
        email: email,
        password: password,
      );

      _chagneState(SignUpSuccessState());
    } catch (e) {
      _chagneState(SignUpErrorState(message: e.toString()));
    }
  }
}
