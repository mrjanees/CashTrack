import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:money_manager/DataBase/Transaction/transaction_db.dart';
import 'package:money_manager/Model/Category/Category_model.dart';
import 'package:money_manager/Screens/Transactions/Add_Transaction_Popup.dart';

import '../../Model/Transaction/TransactionModel.dart';

class Screen_Transaction extends StatelessWidget {
  const Screen_Transaction({super.key});

  @override
  Widget build(BuildContext context) {
    Transaction_DB.instance.RefreshUi;
    return LayoutBuilder(builder: (context, constraints) {
      double h10p = constraints.maxHeight * 0.1;
      double w1p = constraints.maxWidth * 0.01;
      return Padding(
        padding: const EdgeInsets.only(
          right: 10,
          left: 10,
          bottom: 5,
          top: 5,
        ),
        child: ValueListenableBuilder(
          valueListenable: TransactionListNotifier,
          builder:
              (BuildContext ctx, List<TransactionModel> newvalue, Widget? _) {
            return ListView.separated(
              itemBuilder: ((context, index) {
                final data = newvalue[index];
                return Slidable(
                  key: Key(data.id!),
                  startActionPane:
                      ActionPane(motion: const DrawerMotion(), children: [
                    SlidableAction(
                      onPressed: (ctx) {
                        deletingDialog(context, data.id!);
                      },
                      icon: Icons.delete,
                      label: 'Delete',
                      foregroundColor: Colors.red,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ]),
                  child: Card(
                    elevation: 10,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: data.type == categorytype.income
                            ? Colors.teal
                            : Colors.red,
                        radius: 40,
                        child: Text(
                          parseDate(
                            data.date,
                          ),
                          textAlign: TextAlign.center,
                          style:
                              const TextStyle(height: 1, color: Colors.white),
                        ),
                      ),
                      title: Text('Rs ${data.amount.toInt()}'),
                      subtitle: Text(data.category.name),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                insetPadding: EdgeInsets.only(
                                    left: w1p * 8,
                                    right: w1p * 8,
                                    top: h10p * 3,
                                    bottom: h10p * 4),
                                child: Padding(
                                  padding: const EdgeInsets.all(30),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'Rs',
                                            style: TextStyle(
                                                fontSize: 30,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            month(data.date),
                                            style: const TextStyle(
                                                fontSize: 30,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w400),
                                          )
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            data.amount.toInt().toString(),
                                            style: TextStyle(
                                                fontSize: 30,
                                                color: data.type ==
                                                        categorytype.income
                                                    ? Colors.teal
                                                    : Colors.red,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            width: w1p * 6,
                                          ),
                                          Text(
                                            day(data.date),
                                            style: const TextStyle(
                                                fontSize: 30,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          Text(
                                            year(data.date),
                                            style: const TextStyle(
                                                fontSize: 30,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w400),
                                          )
                                        ],
                                      ),
                                      Text(
                                        data.category.name.toString(),
                                        style: const TextStyle(
                                            fontSize: 25,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Container(
                                        child: Text(
                                          data.purpose,
                                          maxLines: 4,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              fontSize: 20,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            });
                      },
                    ),
                  ),
                );
              }),
              separatorBuilder: (context, index) {
                return const SizedBox();
              },
              itemCount: newvalue.length,
            );
          },
        ),
      );
    });
  }

  String parseDate(DateTime value) {
    final dateAsformated = DateFormat.MMMd().format(value);
    final spliteddate = dateAsformated.split(' ');
    return '${spliteddate[1]}\n${spliteddate[0]}';
  }

  String month(DateTime value) {
    final date = DateFormat.yMMMMd().format(value);
    final spliteddate = date.split(' ');
    return spliteddate.first.toString();
  }

  String day(DateTime value) {
    final date = DateFormat.yMMMMd().format(value);
    final spliteddate = date.split(' ');
    return spliteddate[1];
  }

  String year(DateTime value) {
    final date = DateFormat.yMMMMd().format(value);
    final spliteddate = date.split(' ');
    return spliteddate[2];
  }

  void deletingDialog(BuildContext context, String id) {
    showDialog(
        context: context,
        builder: (ctx) {
          return Dialog(
            insetPadding: const EdgeInsets.only(
              left: 40,
              right: 40,
              top: 150,
              bottom: 300,
            ),
            child: Column(children: [
              const SizedBox(
                height: 40,
              ),
              const Text(
                'Do you want to delete?',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Transaction_DB.instance.Deletedata(id);
                      Navigator.of(context).pop(ctx);
                    },
                    child: Text('Yes'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(ctx);
                    },
                    child: Text('No'),
                  )
                ],
              )
            ]),
          );
        });
  }
}
