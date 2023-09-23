import 'dart:ffi';

class MoneyTransaction {
  int? tId;
  late String tName;
  String? tDesc;
  late double tAmt;
  late String tType;
  late String tCat;
  late String tDate;

  MoneyTransaction(this.tName, this.tAmt, this.tCat, this.tDate, this.tType,
      [this.tDesc]);
  MoneyTransaction.withID(
      this.tId, this.tName, this.tAmt, this.tCat, this.tDate, this.tType,
      [this.tDesc]);
  Map<String, dynamic> toMap() {
    Map<String, dynamic> m = {};
    if (tId != null) m['tId'] = tId;
    m['tType'] = tType;
    m['tCat'] = tCat;
    m['tName'] = tName;
    m['tAmt'] = tAmt;
    m['tDate'] = tDate;
    m['tDesc'] = tDesc;
    return m;
  }

  MoneyTransaction.fromMap(Map<String, dynamic> m) {
    this.tId = m['tId'];
    this.tType = m['tType'];
    this.tCat = m['tCat'];
    this.tName = m['tName'];
    this.tAmt = m['tAmt'];
    this.tDate = m['tDate'];
    this.tDesc = m['tDesc'];
  }
}
