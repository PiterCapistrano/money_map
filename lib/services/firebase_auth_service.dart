import 'dart:developer';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:money_map/common/models/user_model.dart';
import 'package:money_map/services/auth_service.dart';

class FirebaseAuthService implements AuthService {
  final _auth = FirebaseAuth.instance;
  final _functions = FirebaseFunctions.instance;

  @override
  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (result.user != null) {
        return UserModel(
          id: result.user!.uid,
          name: result.user!.displayName,
          email: result.user!.email,
        );
      } else {
        throw Exception();
      }
    } on FirebaseAuthException catch (e) {
      throw e.message ?? "null";
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserModel> signUp({
    String? name,
    required String email,
    required String password,
  }) async {
    try {
      await _functions.httpsCallable('registerUser').call({
        "email": email,
        "password": password,
        "displayName": name,
      });
      final result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (result.user != null) {
        log(await _auth.currentUser?.getIdToken(true) ?? 'null');

        await result.user!.updateDisplayName(name);
        return UserModel(
          id: _auth.currentUser?.uid,
          name: _auth.currentUser?.displayName,
          email: _auth.currentUser?.email,
        );
      } else {
        throw Exception();
      }
    } on FirebaseAuthException catch (e) {
      throw e.message ?? "null";
    } on FirebaseFunctionsException catch (e) {
      throw e.message ?? "null";
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      rethrow;
    }
  }
}
