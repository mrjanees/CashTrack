import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:money_manager/DataBase/Transaction/transaction_db.dart';
import 'package:money_manager/Screens/Category/ScreenCategory.dart';
import 'package:money_manager/Screens/Category/Category_Add_Popup.dart';

import 'package:money_manager/Screens/Transactions/Add_Transaction_Popup.dart';
import 'package:money_manager/Screens/Transactions/ScreenTransaction.dart';
import 'package:money_manager/Screens/home/Widgets/BottomNavigation.dart';

import '../../DataBase/Category/category_db.dart';

class Screen_Home extends StatefulWidget {
  const Screen_Home({super.key});
  static ValueNotifier<int> Notifier_index = ValueNotifier(0);

  @override
  State<Screen_Home> createState() => _Screen_HomeState();
}

class _Screen_HomeState extends State<Screen_Home> {
  final pages = const [
    Screen_Transaction(),
    Screen_Category(),
  ];

  @override
  void initState() {
    CategoryDB().RefreshUi();
    Transaction_DB().RefreshUi();
    super.initState();
  }

  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double h10p = constraints.maxHeight * 0.1;
      double w1p = constraints.maxWidth * 0.01;
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          toolbarHeight: 100,
          title: const Text(
            'RupeeSaver',
            style: TextStyle(
                color: Colors.white, fontSize: 30, fontWeight: FontWeight.w500),
          ),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
                gradient: LinearGradient(
                    colors: [Colors.teal, Colors.teal[600]!],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight)),
          ),
        ),
        bottomNavigationBar: const MoneymangerBottomNavigationbar(),
        body: SafeArea(
          child: ValueListenableBuilder(
            valueListenable: Screen_Home.Notifier_index,
            builder: (BuildContext ctx, int newvalue, Widget? _) {
              return pages[newvalue];
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (Screen_Home.Notifier_index.value == 0) {
              Add_Transaction_Popup(context);
            } else if (Screen_Home.Notifier_index.value == 1) {
              // print('Category');
              categoryAddPopup(context, h10p, w1p);
            }
          },
          backgroundColor: Colors.teal,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      );
    });
  }
}
