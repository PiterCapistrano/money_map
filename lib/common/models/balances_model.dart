import 'dart:convert';

class BalancesModel {
  final double totalBalance;
  final double totalIncome;
  final double totalOutcome;

  BalancesModel({
    required this.totalBalance,
    required this.totalIncome,
    required this.totalOutcome,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'totalBalance': totalBalance,
      'totalIncome': totalIncome,
      'totalOutcome': totalOutcome,
    };
  }

  factory BalancesModel.fromMap(Map<String, dynamic> map) {
    return BalancesModel(
      totalBalance: double.tryParse(
              map['totalBalance']['aggregate']['sum']['value'].toString()) ??
          0,
      totalIncome: double.tryParse(
              map['totalIncome']['aggregate']['sum']['value'].toString()) ??
          0,
      totalOutcome: double.tryParse(
              map['totalOutcome']['aggregate']['sum']['value'].toString()) ??
          0,
    );
  }

  String toJson() => json.encode(toMap());

  factory BalancesModel.fromJson(String source) =>
      BalancesModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
