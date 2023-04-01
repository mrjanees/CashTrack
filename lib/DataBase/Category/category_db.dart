import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manager/Model/Category/Category_model.dart';

const CATEGORY_DB_NAME = 'category_datebase';

abstract class CategoryDbFunctions {
  Future<List<categoryModel>> getcategory();
  Future<void> insertCategory(categoryModel value);
  Future<void> deletecategory(String CategoryId);
}

class CategoryDB implements CategoryDbFunctions {
  CategoryDB._internal();
  static CategoryDB instance = CategoryDB._internal();
  factory CategoryDB() {
    return instance;
  }

  ValueNotifier<List<categoryModel>> IncomeListNotifier = ValueNotifier([]);
  ValueNotifier<List<categoryModel>> ExpenseListNotifier = ValueNotifier([]);
  @override
  Future<void> insertCategory(categoryModel value) async {
    final _categoryDb = await Hive.openBox<categoryModel>(CATEGORY_DB_NAME);
    _categoryDb.put(value.Id, value);
    RefreshUi();
  }

  @override
  Future<List<categoryModel>> getcategory() async {
    final _categoryDb = await Hive.openBox<categoryModel>(CATEGORY_DB_NAME);
    return _categoryDb.values.toList();
  }

  Future<void> RefreshUi() async {
    final _allcategories = await getcategory();
    IncomeListNotifier.value.clear();
    ExpenseListNotifier.value.clear();
    Future.forEach(
      _allcategories,
      (categoryModel catefories) {
        if (catefories.type == categorytype.income) {
          IncomeListNotifier.value.add(catefories);
        } else {
          ExpenseListNotifier.value.add(catefories);
        }
      },
    );

    IncomeListNotifier.notifyListeners();
    ExpenseListNotifier.notifyListeners();
  }

  @override
  Future<void> deletecategory(String CategoryId) async {
    final _categoryDb = await Hive.openBox<categoryModel>(CATEGORY_DB_NAME);
    _categoryDb.delete(CategoryId);
    RefreshUi();
  }
}
