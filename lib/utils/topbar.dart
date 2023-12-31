import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_manager/utils/data_provider.dart';
import 'package:money_manager/utils/database_provider.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

import '../services/db_service.dart';
import 'themes.dart';

class TopBar extends StatefulWidget {
  const TopBar({
    super.key,
    required this.provider,
  });

  final ThemeProvider provider;

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  var totalExpense = [];
  var totalIncome = [];
  DBHelper _dbHelper = DBHelper();

  // updateExpenseView() {
  //   final Future<Database> dbFuture = _dbHelper.initDb();
  //   dbFuture.then((value) {
  //     Future<List<Map<String, dynamic>>> expense = _dbHelper.totalExpense();
  //     expense.then((value) {
  //       setState(() {
  //         totalExpense = value;
  //       });
  //       print(value);
  //     });
  //   });
  // }

  // updateIncomeView() {
  //   final Future<Database> dbFuture = _dbHelper.initDb();
  //   dbFuture.then((value) {
  //     Future<List<Map<String, dynamic>>> expense = _dbHelper.totalIncome();
  //     expense.then((value) {
  //       setState(() {
  //         totalIncome = value;
  //       });
  //       print(value);
  //     });
  //   });
  // }

  // updateData() {
  //   updateIncomeView();
  //   updateExpenseView();
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // DatabaseProvider().fetchTopData(context);
    // updateData();
  }

  @override
  Widget build(BuildContext context) {
    // Function expFunc = updateExpenseView();
    // Function incomeFunc = updateIncomeView();
    final dataProvider = Provider.of<DataProvider>(
      context,
    );
    final databaseProvider = Provider.of<DatabaseProvider>(context);
    databaseProvider.fetchTopData(context);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    dataProvider.decrementDate();
                    print(dataProvider.selectedDate);
                  });
                },
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  color: widget.provider.isDark ? Colors.white : Colors.black,
                ),
              ),
              Spacer(),
              Text(
                dataProvider.selectedDate.toString(),
                style: Theme.of(context)
                    .primaryTextTheme
                    .titleLarge!
                    .copyWith(fontSize: 16),
              ),
              Spacer(),
              IconButton(
                onPressed: () {
                  dataProvider.incrementDate();
                  print(dataProvider.selectedDate);
                  setState(() {});
                },
                icon: Icon(
                  Icons.arrow_forward_ios,
                  color: widget.provider.isDark ? Colors.white : Colors.black,
                ),
              ),
              IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) =>
                          StatefulBuilder(builder: (context, setState) {
                            return AlertDialog(
                              backgroundColor: Colors.blueGrey[900],
                              title: Text(
                                'View Mode',
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .titleLarge,
                              ),
                              contentPadding: EdgeInsets.all(10),
                              content: SizedBox(
                                height: 200,
                                width: 200,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextButton(
                                        onPressed: () {
                                          setState(() {
                                            dataProvider
                                                .setFilter(ViewFilter.daily);
                                          });
                                        },
                                        child: Text(
                                          'Daily',
                                          style: Theme.of(context)
                                              .primaryTextTheme
                                              .titleLarge!
                                              .copyWith(
                                                  color: dataProvider.filter ==
                                                          ViewFilter.daily
                                                      ? Colors.yellow
                                                      : (widget.provider.isDark
                                                          ? Colors.white
                                                          : Colors.black),
                                                  fontSize:
                                                      dataProvider.filter ==
                                                              ViewFilter.daily
                                                          ? 18
                                                          : 16,
                                                  fontWeight:
                                                      FontWeight.normal),
                                        )),
                                    TextButton(
                                        onPressed: () {
                                          setState(() {
                                            dataProvider
                                                .setFilter(ViewFilter.weekly);
                                          });
                                        },
                                        child: Text(
                                          'weekly',
                                          style: Theme.of(context)
                                              .primaryTextTheme
                                              .titleLarge!
                                              .copyWith(
                                                  color: dataProvider.filter ==
                                                          ViewFilter.weekly
                                                      ? Colors.yellow
                                                      : (widget.provider.isDark
                                                          ? Colors.white
                                                          : Colors.black),
                                                  fontSize:
                                                      dataProvider.filter ==
                                                              ViewFilter.weekly
                                                          ? 18
                                                          : 16,
                                                  fontWeight:
                                                      FontWeight.normal),
                                        )),
                                    TextButton(
                                        onPressed: () {
                                          dataProvider
                                              .setFilter(ViewFilter.monthly);
                                          setState(() {});
                                        },
                                        child: Text(
                                          'Montly',
                                          style: Theme.of(context)
                                              .primaryTextTheme
                                              .titleLarge!
                                              .copyWith(
                                                  color: dataProvider.filter ==
                                                          ViewFilter.monthly
                                                      ? Colors.yellow
                                                      : (widget.provider.isDark
                                                          ? Colors.white
                                                          : Colors.black),
                                                  fontSize:
                                                      dataProvider.filter ==
                                                              ViewFilter.monthly
                                                          ? 18
                                                          : 16,
                                                  fontWeight:
                                                      FontWeight.normal),
                                        )),
                                    TextButton(
                                        onPressed: () {
                                          dataProvider
                                              .setFilter(ViewFilter.yearly);
                                          setState(() {});
                                        },
                                        child: Text(
                                          'yearly',
                                          style: Theme.of(context)
                                              .primaryTextTheme
                                              .titleLarge!
                                              .copyWith(
                                                  color: dataProvider.filter ==
                                                          ViewFilter.yearly
                                                      ? Colors.yellow
                                                      : (widget.provider.isDark
                                                          ? Colors.white
                                                          : Colors.black),
                                                  fontSize:
                                                      dataProvider.filter ==
                                                              ViewFilter.yearly
                                                          ? 18
                                                          : 16,
                                                  fontWeight:
                                                      FontWeight.normal),
                                        )),
                                  ],
                                ),
                              ),
                            );
                          }));
                },
                icon: Icon(
                  Icons.filter_list,
                  color: widget.provider.isDark ? Colors.white : Colors.black,
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Income',
                    style:
                        Theme.of(context).primaryTextTheme.titleLarge!.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                            ),
                  ),
                  Text(
                    '\$${databaseProvider.totalIncome}',
                    style:
                        Theme.of(context).primaryTextTheme.titleLarge!.copyWith(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Expense',
                    style:
                        Theme.of(context).primaryTextTheme.titleLarge!.copyWith(
                              fontWeight: FontWeight.normal,
                              fontSize: 18,
                            ),
                  ),
                  Text(
                    '\$${databaseProvider.totalExpense}',
                    style:
                        Theme.of(context).primaryTextTheme.titleLarge!.copyWith(
                              color: Colors.red[400],
                            ),
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Balance',
                    style:
                        Theme.of(context).primaryTextTheme.titleLarge!.copyWith(
                              fontWeight: FontWeight.normal,
                              fontSize: 18,
                            ),
                  ),
                  Text(
                    '\$ ${databaseProvider.totalIncome - databaseProvider.totalExpense}',
                    style:
                        Theme.of(context).primaryTextTheme.titleLarge!.copyWith(
                              color: (databaseProvider.loadStatus == true)
                                  ? Colors.grey
                                  : databaseProvider.totalIncome -
                                              databaseProvider.totalExpense >
                                          0
                                      ? Theme.of(context).colorScheme.secondary
                                      : Colors.red[400],
                            ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
