import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manager/Model/Category/Category_model.dart';
import 'package:money_manager/Model/Transaction/TransactionModel.dart';

const TRANSACTION_DB_NAME = 'Transaction_datebase';

abstract class Transaction_Db_functions {
  Future<void> insertTransaction(TransactionModel value);
  Future<List<TransactionModel>> getTransaction();
  void Deletedata(String id);
}

ValueNotifier<List<TransactionModel>> TransactionListNotifier =
    ValueNotifier([]);

class Transaction_DB implements Transaction_Db_functions {
  Transaction_DB._internal();
  static Transaction_DB instance = Transaction_DB._internal();
  factory Transaction_DB() {
    return instance;
  }
  @override
  Future<void> insertTransaction(TransactionModel value) async {
    final transaction_db =
        await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    await transaction_db.put(value.id, value);
  }

  @override
  Future<List<TransactionModel>> getTransaction() async {
    final transaction_db =
        await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    return transaction_db.values.toList();
  }

  Future<void> RefreshUi() async {
    final _allcategories = await getTransaction();
    _allcategories.sort((a, b) => b.date.compareTo(a.date));
    TransactionListNotifier.value.clear();
    TransactionListNotifier.value.addAll(_allcategories);

    TransactionListNotifier.notifyListeners();
  }

  @override
  void Deletedata(String id) async {
    final transaction_db =
        await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    transaction_db.delete(id);
    RefreshUi();
  }
}
