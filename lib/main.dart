import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:money_manager/Model/Category/Category_model.dart';
import 'package:money_manager/Model/Transaction/TransactionModel.dart';
import 'package:money_manager/Screens/home/Screen_home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(categoryModelAdapter().typeId)) {
    Hive.registerAdapter(categoryModelAdapter());
  }
  if (!Hive.isAdapterRegistered(categorytypeAdapter().typeId)) {
    Hive.registerAdapter(categorytypeAdapter());
  }

  if (!Hive.isAdapterRegistered(TransactionModelAdapter().typeId)) {
    Hive.registerAdapter(TransactionModelAdapter());
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.purple,
          scaffoldBackgroundColor: Color.fromARGB(255, 247, 248, 247)),
      home: Screen_Home(),
    );
  }
}
