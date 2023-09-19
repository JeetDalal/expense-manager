import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum ViewFilter { daily, weekly, monthly, yearly }

class DataProvider with ChangeNotifier {
  DateTime _date = DateTime.now();
  ViewFilter _filter = ViewFilter.daily;

  ViewFilter get filter {
    return _filter;
  }

  DateTime get rawDate {
    return _date;
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

  incrementDate() {
    if (_filter == ViewFilter.daily) {
      print(_date);
      // return DateFormat('dd MMMM,yyyy').format(_date);÷
      _date = DateTime(_date.year, _date.month, _date.day + 1);
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

  // String get month {
  //   var month = DateFormat('MMMM,yyyy').format(DateTime.parse(_date));
  //   return month;
  // }
}
