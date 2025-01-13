import 'package:get_it/get_it.dart';
import 'package:money_map/features/sign_in/sign_in_controller.dart';
import 'package:money_map/features/sign_up/sign_up_controller.dart';
import 'package:money_map/features/splash/splash_controller.dart';
import 'package:money_map/services/auth_service.dart';
import 'package:money_map/services/firebase_auth_service.dart';
import 'package:money_map/services/secure_storage.dart';

final locator = GetIt.instance;

void setupDependencies() {
  locator.registerLazySingleton<AuthService>(() => FirebaseAuthService());

  locator.registerFactory<SplashController>(
      () => SplashController(const SecureStorage()));

  locator.registerFactory<SignInController>(
      () => SignInController(locator.get<AuthService>()));
  locator.registerFactory<SignUpController>(
      () => SignUpController(locator.get<AuthService>()));
}
