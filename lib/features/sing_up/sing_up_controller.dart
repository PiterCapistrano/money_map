import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:money_map/features/sing_up/sing_up_state.dart';

class SingUpController extends ChangeNotifier {
  SingUpState _state = SingUpInitialState();

  SingUpState get state => _state;

  void _changeState(SingUpState newState) {
    _state = newState;
    notifyListeners();
  }

  Future<bool> doSingUp() async {
    _changeState(SingUpLoadingState());

    try {
      await Future.delayed(const Duration(seconds: 2));

      throw Exception("Erro ao logar!");

      log("Usuario Logado!");

      _changeState(SingUpSuccessState());

      return true;
    } catch (e) {
      _changeState(SingUpErrorState());
      return false;
    }
  }
}
