import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_manager/DataBase/Category/category_db.dart';
import 'package:money_manager/DataBase/Transaction/transaction_db.dart';
import 'package:money_manager/Model/Category/Category_model.dart';
import 'package:money_manager/Model/Transaction/TransactionModel.dart';
import 'package:money_manager/Screens/Category/Category_Add_Popup.dart';
import 'package:money_manager/Screens/Transactions/Add_Transaction_Popup.dart';
import 'package:money_manager/Screens/home/Widgets/empty_field_shower.dart';

categorytype? radioclicked;
final TextEditingController _purposeTextformcont = TextEditingController();
final TextEditingController _amountTexteditingcont = TextEditingController();
String? selectedCategory;
categoryModel? ontapCategory;
void Add_Transaction_Popup(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (ctx) {
      return Dialog(
        insetPadding: const EdgeInsets.only(
          left: 10,
          right: 10,
          top: 20,
          bottom: 10,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(children: [
              TextFormField(
                controller: _purposeTextformcont,
                decoration: const InputDecoration(
                  hintText: 'Purpose',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _amountTexteditingcont,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Amount',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Date(),
              radiobuttonDropdown(),
              ElevatedButton(
                  onPressed: () {
                    addData(context);
                    Transaction_DB.instance.RefreshUi();
                  },
                  child: const Text(
                    'Submit',
                  ))
            ]),
          ),
        ),
      );
    },
  );
}

class Date extends StatefulWidget {
  const Date({super.key});

  @override
  State<Date> createState() => _DateState();
}

DateTime? selectedDate;

class _DateState extends State<Date> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () async {
        final selectedDateTemp = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now().subtract(
            const Duration(days: 30),
          ),
          lastDate: DateTime.now(),
        );
        if (selectedDateTemp == null) {
          return;
        }
        setState(() {
          selectedDate = selectedDateTemp;
        });
      },
      icon: const Icon(Icons.calendar_today),
      label: Text(
        selectedDate == null
            ? 'selected date'
            : DateFormat.yMMMd().format(selectedDate!),
      ),
    );
  }
}

class radiobuttonDropdown extends StatefulWidget {
  radiobuttonDropdown({super.key});

  @override
  State<radiobuttonDropdown> createState() => _RadioButtonState();
}

class _RadioButtonState extends State<radiobuttonDropdown> {
  @override
  void initState() {
    radioclicked = categorytype.income;
  }

  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: RadioListTile(
                value: categorytype.income,
                groupValue: radioclicked,
                onChanged: (value) {
                  setState(() {
                    radioclicked = value;
                    selectedCategory = null;
                  });
                },
                title: const Text('Income'),
              ),
            ),
            Expanded(
              child: RadioListTile(
                value: categorytype.expense,
                groupValue: radioclicked,
                onChanged: (value) {
                  setState(() {
                    radioclicked = value;
                    selectedCategory = null;
                  });
                },
                title: const Text('Expense'),
              ),
            )
          ],
        ),
        DropdownButton(
            hint: Text(radioclicked == categorytype.income
                ? 'Income Category'
                : 'Expense Category'),
            value: selectedCategory,
            items: (radioclicked == categorytype.income
                    ? CategoryDB().IncomeListNotifier
                    : CategoryDB().ExpenseListNotifier)
                .value
                .map((e) {
              return DropdownMenuItem(
                child: Text(e.name),
                value: e.Id,
                onTap: () {
                  ontapCategory = e;
                },
              );
            }).toList(),
            onChanged: (Selectedvalue) {
              setState(() {
                selectedCategory = Selectedvalue;
              });
            })
      ],
    );
  }
}

void addData(context) {
  final purpose = _purposeTextformcont.text;
  final amount = _amountTexteditingcont.text;
  final parsedAmount = double.tryParse(amount);
  if (purpose.isEmpty) {
    emptyFieldHandler(context, 'Please Enter the Purpose');
  } else if (parsedAmount == null) {
    emptyFieldHandler(context, 'Please Enter the amount');
  } else if (selectedDate == null) {
    emptyFieldHandler(context, 'Please Enter the date');
  } else if (ontapCategory == null) {
    emptyFieldHandler(context, 'Select the category');
  } else {
    final transation = TransactionModel(
        purpose: purpose,
        amount: parsedAmount,
        date: selectedDate!,
        type: radioclicked!,
        category: ontapCategory!,
        id: DateTime.now().millisecondsSinceEpoch.toString());
    Transaction_DB.instance.insertTransaction(transation);

    _amountTexteditingcont.clear();
    _purposeTextformcont.clear();
    selectedCategory = null;
    radioclicked = categorytype.income;
    selectedDate = null;
    ontapCategory = null;
    Navigator.of(context).pop(context);
  }
}
