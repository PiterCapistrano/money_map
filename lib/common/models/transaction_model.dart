import 'dart:convert';

class TransactionModel {
  final String id;
  final String category;
  final String description;
  final double value;
  final int date;
  final bool status;

  TransactionModel({
    required this.id,
    required this.category,
    required this.description,
    required this.value,
    required this.date,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'category': category,
      'description': description,
      'value': value,
      'date': date,
      'status': status,
    };
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    bool parsedStatus = false;
    if (map['status'] is int) {
      parsedStatus = map['status'] == 0 ? false : true;
    }
    return TransactionModel(
      id: map['id'] as String,
      category: map['category'] as String,
      description: map['description'] as String,
      value: double.tryParse(map['value'].toString()) ?? 0,
      date: DateTime.parse(map['date'] as String).millisecondsSinceEpoch,
      status: map['status'] is int ? parsedStatus : map['status'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory TransactionModel.fromJson(String source) =>
      TransactionModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
