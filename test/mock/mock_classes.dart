import 'package:mocktail/mocktail.dart';
import 'package:money_map/services/auth_service.dart';
import 'package:money_map/services/secure_storage.dart';

class MockFirebaseAuthService extends Mock implements AuthService {}

class MockSecureStorage extends Mock implements SecureStorage {}
