import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_manager/models/transaction.dart';
import 'package:money_manager/services/db_service.dart';
// import 'package:money_manager/services/expense_db.dart';
import 'package:money_manager/utils/data_provider.dart';
import 'package:money_manager/utils/database_provider.dart';
import 'package:money_manager/utils/order_tile.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

import '../utils/transaction_history_card.dart';

class Records extends StatefulWidget {
  const Records({super.key});

  @override
  State<Records> createState() => _RecordsState();
}

class _RecordsState extends State<Records> {
  List records = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final provider = Provider.of<DataProvider>(context, listen: false);
      provider.moneyTransactionList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final dateProvider = Provider.of<DataProvider>(context);
    final databaseProvider = Provider.of<DatabaseProvider>(context);

    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              "Records for ${dateProvider.selectedDate}",
              style: Theme.of(context).primaryTextTheme.titleLarge,
            ),
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              height: 500,
              child: Consumer<DataProvider>(
                builder: (context, value, child) {
                  return value.transactionList.isNotEmpty
                      ? ListView.builder(
                          itemCount: dateProvider.transactionList.length,
                          itemBuilder: (context, index) {
                            // print(databaseProvider.transactionList)
                            return Column(
                              children: [
                                OrderTile(
                                  cat: dateProvider.transactionList[index].tCat,
                                  amount:
                                      dateProvider.transactionList[index].tAmt,
                                  date:
                                      dateProvider.transactionList[index].tDate,
                                  desc: dateProvider
                                          .transactionList[index].tDesc ??
                                      "",
                                  title:
                                      dateProvider.transactionList[index].tName,
                                  type:
                                      dateProvider.transactionList[index].tType,
                                ),
                                index != dateProvider.transactionList.length - 1
                                    ? const Divider(
                                        color: Colors.grey,
                                        thickness: 0.5,
                                      )
                                    : Container(),
                              ],
                            );
                          })
                      : value.transactionList.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.receipt_long,
                                    color: Colors.blueGrey,
                                    size: 60,
                                  ),
                                  Text(
                                    "No Transactions Recorded ",
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .titleLarge!
                                        .copyWith(
                                          color: Colors.blueGrey,
                                        ),
                                  ),
                                ],
                              ),
                            )
                          : Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
