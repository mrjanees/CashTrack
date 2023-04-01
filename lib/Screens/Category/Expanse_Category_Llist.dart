import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:money_manager/DataBase/Category/category_db.dart';

import '../../Model/Category/Category_model.dart';

class Expense_category_list extends StatelessWidget {
  const Expense_category_list({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: CategoryDB().ExpenseListNotifier,
        builder: (BuildContext ctx, List<categoryModel> newvalue, Widget? _) {
          return ListView.separated(
            itemBuilder: (context, index) {
              final data = newvalue[index];
              return Card(
                elevation: 10,
                child: ListTile(
                  title: Text(data.name),
                  trailing: IconButton(
                    onPressed: () {
                      CategoryDB().deletecategory(data.Id);
                    },
                    icon: const Icon(Icons.delete),
                  ),
                ),
              );
            },
            separatorBuilder: (context, indux) {
              return const SizedBox(
                height: 10,
              );
            },
            itemCount: newvalue.length,
          );
        });
  }
}
