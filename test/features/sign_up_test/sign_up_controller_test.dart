import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:money_map/common/models/user_model.dart';
import 'package:money_map/features/sign_up/sign_up_controller.dart';
import 'package:money_map/features/sign_up/sign_up_state.dart';

import '../../mock/mock_classes.dart';

void main() {
  late SignUpController signUpController;
  late MockSecureStorage mockSecureStorage;
  late MockFirebaseAuthService mockFirebaseAuthService;
  late MockGraphQlService mockGraphQlService;
  late UserModel user;

  setUp(() {
    mockFirebaseAuthService = MockFirebaseAuthService();
    mockSecureStorage = MockSecureStorage();
    mockGraphQlService = MockGraphQlService();

    signUpController = SignUpController(
      authService: mockFirebaseAuthService,
      secureStorage: mockSecureStorage,
      graphQlService: mockGraphQlService,
    );
    user = UserModel(
      name: 'User',
      email: 'user@gmail.com',
      id: '1a2b3c4d5e',
    );
  });

  test('Test Sign Up Controller Success State', () async {
    expect(signUpController.state, isInstanceOf<SignUpInitialState>());

    when(
      () => mockSecureStorage.write(
        key: "CURRENT_USER",
        value: user.toJson(),
      ),
    ).thenAnswer((_) async {});

    when(
      () => mockFirebaseAuthService.signUp(
        name: 'User',
        email: 'user@gmail.com',
        password: 'user@123',
      ),
    ).thenAnswer(
      (_) async => user,
    );

    await signUpController.signUp(
      name: 'User',
      email: 'user@gmail.com',
      password: 'user@123',
    );
    expect(signUpController.state, isInstanceOf<SignUpSuccessState>());
  });

  test('Test Sign Up Controller Error State', () async {
    expect(signUpController.state, isInstanceOf<SignUpInitialState>());

    when(() => mockGraphQlService.init()).thenAnswer((_) async => {});

    when(
      () => mockSecureStorage.write(
        key: "CURRENT_USER",
        value: user.toJson(),
      ),
    ).thenAnswer((_) async {});

    when(
      () => mockFirebaseAuthService.signUp(
        name: 'User',
        email: 'user@gmail.com',
        password: 'user@123',
      ),
    ).thenThrow(
      Exception(),
    );

    await signUpController.signUp(
      name: 'User',
      email: 'user@gmail.com',
      password: 'user@123',
    );
    expect(signUpController.state, isInstanceOf<SignUpErrorState>());
  });
}
