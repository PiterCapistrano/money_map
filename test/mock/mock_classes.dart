import 'package:mocktail/mocktail.dart';
import 'package:money_map/common/models/user_model.dart';
import 'package:money_map/services/auth_service.dart';
import 'package:money_map/services/graphql_service.dart';
import 'package:money_map/services/secure_storage.dart';

class MockFirebaseAuthService extends Mock implements AuthService {}

class MockSecureStorage extends Mock implements SecureStorage {}

class MockGraphQlService extends Mock implements GraphQlService {}

class MockUser extends Mock implements UserModel {}
