import 'package:flutter/foundation.dart';
import 'package:money_map/common/models/transaction_model.dart';
import 'package:money_map/common/models/user_model.dart';
import 'package:money_map/repositories/transaction_repository.dart';
import 'package:money_map/services/secure_storage.dart';
import 'transaction_state.dart';

class TransactionController extends ChangeNotifier {
  final TransactionRepository repository;
  final SecureStorage storage;

  TransactionController({
    required this.repository,
    required this.storage,
  });

  TransactionState _state = TransactionStateInitial();

  TransactionState get state => _state;

  void _changeState(TransactionState newState) {
    _state = newState;
    notifyListeners();
  }

  Future<void> addTransaction(TransactionModel transaction) async {
    _changeState(TransactionStateLoading());
    try {
      final data = await storage.readOne(key: 'CURRENT_USER');
      final user = UserModel.fromJson(data ?? '');
      final result = await repository.addTransaction(
        transaction,
        user.id!,
      );

      if (result) {
        _changeState(TransactionStateSuccess());
      } else {
        throw Exception('error');
      }
    } catch (e) {
      _changeState(TransactionStateError());
    }
  }

  Future<void> updateTransaction(TransactionModel transaction) async {
    _changeState(TransactionStateLoading());
    try {
      final result = await repository.updateTransaction(transaction);

      if (result) {
        _changeState(TransactionStateSuccess());
      } else {
        throw Exception('error');
      }
    } catch (e) {
      _changeState(TransactionStateError());
    }
  }
}
