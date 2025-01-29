import 'dart:developer';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:money_map/common/constants/queries/get_all_transactions.dart';
import 'package:money_map/common/models/transaction_model.dart';
import 'package:money_map/locator.dart';
import 'package:money_map/services/graphql_service.dart';

abstract class TransactionRepository {
  Future<void> addTransaction();
  Future<List<TransactionModel>> getAllTransactions();
}

class TransactionRepositoryImpl implements TransactionRepository {
  final client = locator.get<GraphQlService>().client;

  @override
  Future<void> addTransaction() {
    throw UnimplementedError();
  }

  @override
  Future<List<TransactionModel>> getAllTransactions() async {
    try {
      final response =
          await client.query(QueryOptions(document: gql(qGetAllTransactions)));

      log(response.data.toString());
      final parsedData = List.from(response.data?['transaction'] ?? []);

      final transactions =
          parsedData.map((e) => TransactionModel.fromMap(e)).toList();
      return transactions;
    } catch (e) {
      rethrow;
    }
  }
}
