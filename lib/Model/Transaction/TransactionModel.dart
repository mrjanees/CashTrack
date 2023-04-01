import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manager/Model/Category/Category_model.dart';
part 'TransactionModel.g.dart';

@HiveType(typeId: 3)
class TransactionModel {
  @HiveField(0)
  final String purpose;
  @HiveField(1)
  final double amount;
  @HiveField(2)
  final DateTime date;
  @HiveField(3)
  final categorytype type;
  @HiveField(4)
  final categoryModel category;
  @HiveField(5)
  final String? id;

  TransactionModel({
    required this.purpose,
    required this.amount,
    required this.date,
    required this.type,
    required this.category,
    this.id,
  });
}
