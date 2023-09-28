import 'dart:developer';
import 'dart:io';
// import 'dart:js';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_manager/models/transaction.dart';
import 'package:money_manager/utils/data_provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DBHelper {
  static DBHelper? _dbHelper;
  static Database? _database;

  String tableName = 'transactionTable';
  String colId = 'tId';
  String colName = 'tName';
  String colCat = 'tCat';
  String colAmt = 'tAmt';
  String colDesc = 'tDesc';
  String colType = 'tType';
  String colDate = 'tDate';

  DBHelper._createInstance();

  factory DBHelper() {
    if (_dbHelper == null) {
      // print('creating new Instance');
      _dbHelper = DBHelper._createInstance();
    }
    // print('Instanciated');
    return _dbHelper!;
  }

  Future<Database> initDb() async {
    print('init');
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'transactions.db';
    var transactionDb =
        await openDatabase(path, version: 1, onCreate: _createDb);

    return transactionDb;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initDb();
    }
    return _database!;
  }

  void _createDb(Database db, int version) async {
    print('Creating Table');
    await db.execute(
      'CREATE TABLE IF NOT EXISTS $tableName($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colType TEXT NOT NULL,$colName TEXT NOT NULL,$colCat TEXT NOT NULL,$colAmt FLOAT NOT NULL,$colDate DATE NOT NULL,$colDesc TEXT);',
    );
  }

  getTransactionList(DateTime date, ViewFilter filter) async {
    Database db = await database;
    var result;
    print(date);
    // if (filter == ViewFilter.daily) {
    //   result = db.rawQuery('SELECT * FROM $tableName');
    // } else if (filter == ViewFilter.monthly) {
    //   result = db.rawQuery(
    //       'SELECT * FROM $tableName WHERE tDate BETWEEN ${date.year}-${date.month}-1 and ${date.year}-${date.month}-31');
    // }
    result = db.rawQuery('SELECT * FROM $tableName WHERE $colDate = ?',
        [DateFormat('yyyy-MM-dd').format(date)]);
    return result;
  }

  getTransactionByCategory(DateTime date, ViewFilter filter) async {
    Database db = await database;
    var result;

    result = db.rawQuery(
        'SELECT sum($colAmt) as total , $colCat FROM $tableName WHERE $colDate = ? and $colType=? GROUP BY $colCat',
        [DateFormat('yyyy-MM-dd').format(date), "Expense"]);
    return result;
  }

  Future<int> insertTransaction(MoneyTransaction transaction) async {
    Database database = await this.database;
    final result = await database.insert(tableName, transaction.toMap());
    return result;
  }

  fetchTotalExpense(BuildContext context) async {
    Database db = await database;
    var result;
    var dataProvider = Provider.of<DataProvider>(context, listen: false);
    result = db.rawQuery(
        'SELECT sum($colAmt) as total FROM $tableName WHERE $colType= ? and $colDate=?',
        ["Expense", DateFormat('yyyy-MM-dd').format(dataProvider.rawDate)]);
    // print(result);
    return result;
  }

  fetchTotalIncome(BuildContext context) async {
    Database db = await database;
    var result;
    var dataProvider = Provider.of<DataProvider>(context, listen: false);
    result = db.rawQuery(
        'SELECT sum($colAmt) as total FROM $tableName WHERE $colType= ? and $colDate = ?',
        ["Income", DateFormat('yyyy-MM-dd').format(dataProvider.rawDate)]);
    // print(result);
    return result;
  }

  Future<List<Map<String, dynamic>>> totalIncome(BuildContext context) async {
    var tMapList = await fetchTotalIncome(context);
    List<Map<String, dynamic>> tList = [];
    for (int i = 0; i < tMapList.length; i++) {
      // print(tMapList[i]);
      tList.add(tMapList[i]);
    }
    // print(tMapList.toString());
    return tMapList;
  }

  fetchMonthWiseData(DateTime date) async {
    Database db = await database;
    var result;
    // var dataProvider = Provider.of<DataProvider>(context, listen: false);
    result = db.rawQuery('''
      SELECT strftime('%m', $colDate) as month, SUM($colAmt) as total
      FROM $tableName WHERE
      $colType=?
      GROUP BY month
    ''', ["Expense"]);
    print("This is monthwise data : " + result.toString());
    return result;
  }

  Future<List<Map<String, dynamic>>> monthWiseData(DateTime date) async {
    var tMapList = await fetchMonthWiseData(date);
    List<Map<String, dynamic>> tList = [];
    for (int i = 0; i < tMapList.length; i++) {
      // print(tMapList[i]);
      tList.add(tMapList[i]);
    }
    // print(tMapList.toString());
    return tMapList;
  }

  // Future<List<Map<String, dynamic>>> totalExpense() async {

  // }
}
