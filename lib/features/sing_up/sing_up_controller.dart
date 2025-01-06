import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:money_map/features/sing_up/sing_up_state.dart';
import 'package:money_map/services/auth_service.dart';

class SingUpController extends ChangeNotifier {
  final AuthService _service;

  SingUpController(this._service);

  SingUpState _state = SingUpInitialState();

  SingUpState get state => _state;

  void _changeState(SingUpState newState) {
    _state = newState;
    notifyListeners();
  }

  Future<void> singUp({
    String? name,
    required String email,
    required String password,
  }) async {
    _changeState(SingUpLoadingState());

    try {
      await _service.singUp(
        name: name,
        email: email,
        password: password,
      );

      _changeState(SingUpSuccessState());
    } catch (e) {
      _changeState(SingUpErrorState(message: e.toString()));
    }
  }
}
