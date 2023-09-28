import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_manager/models/transaction.dart';
import 'package:money_manager/services/db_service.dart';
import 'package:money_manager/utils/category.dart';
import 'package:money_manager/utils/database_provider.dart';
import 'package:sqflite/sqflite.dart';

enum ViewFilter { daily, weekly, monthly, yearly }

class DataProvider with ChangeNotifier {
  DateTime _date = DateTime.now();
  ViewFilter _filter = ViewFilter.daily;
  Category _category = categories[0];
  List<MoneyTransaction> _transactionList = [];
  List<Map<String, dynamic>> _categoryData = [];
  List<Map<String, dynamic>> _monthWiseData = [];

  Category get category {
    return _category;
  }

  List<Map<String, dynamic>> get monthWiseData {
    return _monthWiseData;
  }

  List<Map<String, dynamic>> get categoryData {
    return _categoryData;
  }

  List<MoneyTransaction> get transactionList {
    return _transactionList;
  }

  setCategory(Category category) {
    _category = category;
    notifyListeners();
  }

  ViewFilter get filter {
    return _filter;
  }

  DateTime get rawDate {
    return _date;
  }

  getMonthWiseData() async {
    var tMapList = await DBHelper().fetchMonthWiseData(_date);
    _monthWiseData = tMapList;
    print("The monthwise data : " + tMapList.toString());
    notifyListeners();
  }

  String get selectedDate {
    if (_filter == ViewFilter.daily) {
      return DateFormat('dd MMMM,yyyy').format(_date);
    } else if (_filter == ViewFilter.monthly) {
      return DateFormat('MMMM,yyyy').format(_date);
    } else if (_filter == ViewFilter.weekly) {
      var weekEndDate = _date.add(const Duration(days: 7));
      return DateFormat('MMMM,dd')
              .format(DateTime(_date.year, _date.month, _date.day + 1)) +
          " " +
          "-" +
          " " +
          DateFormat('MMMM,dd').format(weekEndDate);
    } else {
      return DateFormat('yyyy').format(_date);
    }
  }

  setFilter(ViewFilter filter) {
    _filter = filter;
    notifyListeners();
  }

  fetchMonthlyData() async {
    var tMapList = await DBHelper().fetchMonthWiseData(_date);
    // print("Hello");
    // print(tMapList);?
    _monthWiseData = tMapList;
    notifyListeners();
  }

  incrementDate() {
    if (_filter == ViewFilter.daily) {
      print(_date);
      // return DateFormat('dd MMMM,yyyy').format(_date);÷
      _date = DateTime(_date.year, _date.month, _date.day + 1);
      moneyTransactionList();
      moneyTransactionListByCategory();
      print(_date);
    } else if (_filter == ViewFilter.monthly) {
      _date = DateTime(_date.year, _date.month + 1, _date.day);
    } else if (_filter == ViewFilter.weekly) {
      _date = DateTime(_date.year, _date.month, _date.day + 7);
    } else {
      _date = DateTime(_date.year + 1, _date.month, _date.day);
    }
    notifyListeners();
  }

  decrementDate() {
    if (_filter == ViewFilter.daily) {
      // return DateFormat('dd MMMM,yyyy').format(_date);÷
      _date = DateTime(_date.year, _date.month, _date.day - 1);
      moneyTransactionList();
      moneyTransactionListByCategory();
    } else if (_filter == ViewFilter.monthly) {
      _date = DateTime(_date.year, _date.month - 1, _date.day);
    } else if (_filter == ViewFilter.weekly) {
      _date =
          DateTime(_date.year, _date.month, _date.day - _date.weekday % 7 - 1);
    } else {
      _date = DateTime(_date.year - 1, _date.month, _date.day + 1);
    }
    notifyListeners();
  }

  moneyTransactionList() async {
    print("He");
    var tMapList = await DBHelper().getTransactionList(_date, _filter);
    // print("Hello");
    List<MoneyTransaction> tList = [];
    for (int i = 0; i < tMapList.length; i++) {
      // print(tMapList[i]);
      tList.add(MoneyTransaction.fromMap(tMapList[i]));
    }
    _transactionList = tList;
    print(tMapList);
    notifyListeners();
  }

  moneyTransactionListByCategory() async {
    print("He");
    var tMapList = await DBHelper().getTransactionByCategory(_date, _filter);
    // print("Hello");
    // print(tMapList);?
    _categoryData = tMapList;
    print(_categoryData);
    notifyListeners();
  }

  // String get month {
  //   var month = DateFormat('MMMM,yyyy').format(DateTime.parse(_date));
  //   return month;
  // }
}
