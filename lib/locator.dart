import 'package:get_it/get_it.dart';
import 'package:money_map/features/home/home_controller.dart';
import 'package:money_map/features/home/widgets/balance_card/balance_card_widget_controller.dart';
import 'package:money_map/features/sign_in/sign_in_controller.dart';
import 'package:money_map/features/sign_up/sign_up_controller.dart';
import 'package:money_map/features/splash/splash_controller.dart';
import 'package:money_map/repositories/transaction_repository.dart';
import 'package:money_map/services/auth_service.dart';
import 'package:money_map/services/firebase_auth_service.dart';
import 'package:money_map/services/graphql_service.dart';
import 'package:money_map/services/secure_storage.dart';

final locator = GetIt.instance;

void setupDependencies() {
  locator.registerFactory<AuthService>(
    () => FirebaseAuthService(),
  );

  locator.registerLazySingleton<GraphQlService>(
    () => GraphQlService(authService: locator.get<AuthService>()),
  );

  locator.registerFactory<SplashController>(() => SplashController(
        secureStorage: const SecureStorage(),
        graphQlService: locator.get<GraphQlService>(),
      ));

  locator.registerFactory<SignInController>(() => SignInController(
        authService: locator.get<AuthService>(),
        secureStorage: const SecureStorage(),
        graphQlService: locator.get<GraphQlService>(),
      ));

  locator.registerFactory<SignUpController>(() => SignUpController(
        authService: locator.get<AuthService>(),
        secureStorage: const SecureStorage(),
        graphQlService: locator.get<GraphQlService>(),
      ));

  locator.registerFactory<TransactionRepository>(
      () => TransactionRepositoryImpl());

  locator.registerLazySingleton<HomeController>(
      () => HomeController(locator.get<TransactionRepository>()));

  locator.registerLazySingleton<BalanceCardWidgetController>(() =>
      BalanceCardWidgetController(
          transactionRepository: locator.get<TransactionRepository>()));
}
