import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:money_map/common/models/user_model.dart';

import '../mock/mock_classes.dart';

void main() {
  late MockFirebaseAuthService mockFirebaseAuthService;
  late UserModel user;
  setUp(() {
    mockFirebaseAuthService = MockFirebaseAuthService();
    user = UserModel(
      name: 'User',
      email: 'user@gmail.com',
      id: '1a2b3c4d5e',
    );
  });

  // método de simulação de retorno do método signUp
  test('Teste sign up success', () async {
    when(
      () => mockFirebaseAuthService.signUp(
        name: 'User',
        email: 'user@gmail.com',
        password: 'user@123',
      ),
    ).thenAnswer(
      (_) async => user,
    );

    final result = await mockFirebaseAuthService.signUp(
      name: 'User',
      email: 'user@gmail.com',
      password: 'user@123',
    );

    expect(
      result,
      user,
    );
  });

  test('Teste sign up failure', () async {
    when(
      () => mockFirebaseAuthService.signUp(
        name: 'User',
        email: 'user@gmail.com',
        password: 'user@123',
      ),
    ).thenThrow(
      Exception(),
    );

    expect(
      () => mockFirebaseAuthService.signUp(
        name: 'User',
        email: 'user@gmail.com',
        password: 'user@123',
      ),
      //throwsException,
      throwsA(isInstanceOf<Exception>()),
    );
  });
}
