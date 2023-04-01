import 'package:hive_flutter/hive_flutter.dart';
part 'Category_model.g.dart';

@HiveType(typeId: 1)
class categoryModel {
  @HiveField(0)
  final String Id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final bool isDatadeleted;
  @HiveField(3)
  final categorytype type;

  categoryModel({
    required this.Id,
    required this.name,
    this.isDatadeleted = false,
    required this.type,
  });
}

@HiveType(typeId: 2)
enum categorytype {
  @HiveField(0)
  income,
  @HiveField(1)
  expense,
}
