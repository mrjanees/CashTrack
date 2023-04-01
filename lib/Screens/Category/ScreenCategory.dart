import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:money_manager/DataBase/Category/category_db.dart';
import 'package:money_manager/Screens/Category/Expanse_Category_Llist.dart';
import 'package:money_manager/Screens/Category/Income_Category_List.dart';

class Screen_Category extends StatefulWidget {
  const Screen_Category({super.key});

  @override
  State<Screen_Category> createState() => _Screen_CategoryState();
}

class _Screen_CategoryState extends State<Screen_Category>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          labelColor: Colors.teal,
          unselectedLabelColor: Colors.grey,
          tabs: const [
            Tab(
              text: 'Income',
            ),
            Tab(
              text: 'Expense',
            ),
          ],
        ),
        Expanded(
          child: TabBarView(
              
              controller: _tabController,
              children: const [
                Income_cate_List(),
                Expense_category_list(),
              ]),
        ),
      ],
    );
  }
}
