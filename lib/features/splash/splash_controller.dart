import 'package:flutter/foundation.dart';
import 'package:money_map/features/splash/splash_state.dart';
import 'package:money_map/services/graphql_service.dart';
import 'package:money_map/services/secure_storage.dart';

class SplashController extends ChangeNotifier {
  final SecureStorage secureStorage;
  final GraphQlService graphQlService;

  SplashController({
    required this.secureStorage,
    required this.graphQlService,
  });

  SplashState _state = SplashStateInitial();

  SplashState get state => _state;

  void _changeState(SplashState newState) {
    _state = newState;
    notifyListeners();
  }

  void isUserLogged() async {
    final result = await secureStorage.readOne(key: "CURRENT_USER");

    if (result != null) {
      await graphQlService.init();

      _changeState(SplashStateSuccess());
    } else {
      _changeState(SplashStateError());
    }
  }
}
