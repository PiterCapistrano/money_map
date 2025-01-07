import 'package:flutter/foundation.dart';
import 'package:money_map/features/sign_in/sign_in_state.dart';
import 'package:money_map/services/auth_service.dart';

class SignInController extends ChangeNotifier {
  final AuthService _service;

  SignInState _state = SignInStateInitial();

  SignInController(this._service);

  SignInState get state => _state;

  void _changeState(SignInState newState) {
    _state = newState;
    notifyListeners();
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    _changeState(SignInStateLoading());

    try {
      await _service.signIn(
        email: email,
        password: password,
      );

      _changeState(SignInStateSuccess());
    } catch (e) {
      _changeState(SignInStateError(e.toString()));
    }
  }
}
