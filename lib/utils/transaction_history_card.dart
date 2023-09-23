import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_manager/models/transaction.dart';
import 'package:money_manager/services/db_service.dart';
import 'package:money_manager/utils/data_provider.dart';
import 'package:money_manager/utils/order_tile.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqlite_api.dart';

import '../screens/records.dart';

class TransactionHistoryCard extends StatefulWidget {
  const TransactionHistoryCard({
    super.key,
    required this.dateProvider,
  });

  final DataProvider dateProvider;

  @override
  State<TransactionHistoryCard> createState() => _TransactionHistoryCardState();
}

class _TransactionHistoryCardState extends State<TransactionHistoryCard> {
  DBHelper dbHelper = DBHelper();
  List<MoneyTransaction> tList = [];
  int count = 0;

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context);
    // updateView() {
    //   final Future<Database> dbFuture = dbHelper.initDb();
    //   dbFuture.then((value) {
    //     Future<List<MoneyTransaction>> transactions = dbHelper
    //         .moneyTransactionList(dataProvider.rawDate, dataProvider.filter);
    //     transactions.then((value) {
    //       this.tList = value;
    //       this.count = count;
    //       print(tList);
    //     });
    //   });
    // }

    // updateView();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          DateFormat('dd MMMM,yyyy').format(widget.dateProvider.rawDate),
          style: Theme.of(context).primaryTextTheme.titleLarge,
        ),
        const Divider(
          color: Colors.grey,
          thickness: 2,
        ),
      ],
    );
  }
}
