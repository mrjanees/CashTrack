import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_manager/DataBase/Category/category_db.dart';
import 'package:money_manager/Model/Category/Category_model.dart';

ValueNotifier<categorytype> selectedCategoryNotifier =
    ValueNotifier(categorytype.income);

final _nameEditingController = TextEditingController();

categoryAddPopup(BuildContext context, double h10p, w1p) async {
  return showDialog(
    context: context,
    builder: (ctx) {
      return SingleChildScrollView(
        child: Dialog(
          insetPadding: EdgeInsets.only(
              left: w1p * 8, right: w1p * 8, top: h10p * 2.5, bottom: h10p * 3),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: h10p * 0.2),
                child: Text(
                  'Add Category',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: Colors.purple[800]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _nameEditingController,
                  decoration: const InputDecoration(
                    hintText: 'Category Name',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: const [
                    RadioButton(title: 'Income', type: categorytype.income),
                    RadioButton(title: 'Expense', type: categorytype.expense),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: ElevatedButton(
                    onPressed: () {
                      final _name = _nameEditingController.text;
                      if (_name.isEmpty) {
                        return;
                      }
                      final _type = selectedCategoryNotifier.value;
                      final _category = categoryModel(
                          Id: DateTime.now().millisecondsSinceEpoch.toString(),
                          name: _name,
                          type: _type);
                      CategoryDB().insertCategory(_category);

                      Navigator.pop(ctx);
                    },
                    child: Text('Submit')),
              )
            ],
          ),
        ),
      );
    },
  );
}

class RadioButton extends StatelessWidget {
  final String title;
  final categorytype type;
  const RadioButton({super.key, required this.title, required this.type});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder(
            valueListenable: selectedCategoryNotifier,
            builder: (BuildContext ctx, newcategory, Widget? _) {
              return Radio<categorytype>(
                value: type,
                groupValue: newcategory,
                onChanged: (value) {
                  if (value != null) {
                    selectedCategoryNotifier.value = value;
                    selectedCategoryNotifier.notifyListeners();
                  }
                },
              );
            }),
        Text(title)
      ],
    );
  }
}
