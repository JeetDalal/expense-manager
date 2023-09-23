import 'package:flutter/material.dart';
import 'package:money_manager/models/transaction.dart';
import 'package:money_manager/services/db_service.dart';
import 'package:money_manager/utils/data_provider.dart';

class DatabaseProvider with ChangeNotifier {
  double _totalExpense = 0.0;
  double _totalIncome = 0.0;
  double _balance = 0.0;
  bool _loadTopContent = false;
  List<MoneyTransaction> _transactionList = [];

  double get totalExpense {
    // print(_totalExpense);
    return _totalExpense;
  }

  double get totalIncome {
    // print(_totalIncome);
    return _totalIncome;
  }

  double get balance {
    return _balance;
  }

  bool get loadStatus {
    return _loadTopContent;
  }

  List<MoneyTransaction> get transactionList {
    return _transactionList;
  }

  _getTotalExpenseFromDb(BuildContext context) async {
    var tMapList = await DBHelper().fetchTotalExpense(context);
    List<Map<String, dynamic>> tList = [];
    for (int i = 0; i < tMapList.length; i++) {
      // print(tMapList[i]);
      tList.add(tMapList[i]);
    }
    // print(tList);
    _totalExpense = tList[0]['total'] ?? 0.0;
    notifyListeners();
    // _loadTopContent = false;
  }

  _getTotalIncomeFromDb(BuildContext context) async {
    var tMapList = await DBHelper().fetchTotalIncome(context);
    List<Map<String, dynamic>> tList = [];
    for (int i = 0; i < tMapList.length; i++) {
      // print(tMapList[i]);
      tList.add(tMapList[i]);
    }
    _totalIncome = tList[0]['total'] ?? 0.0;
    // print("hello");
    notifyListeners();
    // _loadTopContent = false;
  }

  fetchTopData(BuildContext context) {
    _getTotalIncomeFromDb(context);
    _getTotalExpenseFromDb(context);

    _balance = _totalIncome - _totalIncome;
    // _loadTopContent = false;
    // notifyListeners();
  }
}
