// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_manager/models/transaction.dart';
import 'package:money_manager/services/db_service.dart';
import 'package:money_manager/utils/category.dart';
import 'package:money_manager/utils/data_provider.dart';
import 'package:money_manager/utils/themes.dart';
import 'package:money_manager/utils/topbar.dart';
import 'package:provider/provider.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  bool isExpense = false;
  var amt = "";
  var _selectedDate = DateTime.now();
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final dataProvider = Provider.of<DataProvider>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          // vertical: 20,
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(
                    Icons.cancel,
                    size: 40,
                    color: themeProvider.isDark ? Colors.white : Colors.black,
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    if (amt != "") {
                      MoneyTransaction m = MoneyTransaction(
                        dataProvider.category.catName,
                        double.parse(amt),
                        dataProvider.category.catName,
                        DateFormat('yyyy-MM-dd').format(_selectedDate),
                        isExpense ? "Expense" : "Income",
                        _controller.text,
                      );
                      await DBHelper().insertTransaction(m).then((value) {
                        print(value);
                        if (value == 0) {
                          const SnackBar(content: Text('Record Not saved'));
                        } else {
                          SnackBar(
                            backgroundColor: Colors.grey,
                            content: Text(
                              'Record Saved Successfully',
                              style:
                                  Theme.of(context).primaryTextTheme.titleLarge,
                            ),
                          );

                          Navigator.of(context).pop();
                        }
                      });
                    }
                  },
                  icon: Icon(
                    Icons.check_circle,
                    size: 40,
                    color: themeProvider.isDark ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isExpense = false;
                    });
                  },
                  child: Text(
                    'Income',
                    style: isExpense
                        ? Theme.of(context)
                            .primaryTextTheme
                            .titleLarge!
                            .copyWith(
                                fontWeight: FontWeight.normal, fontSize: 18)
                        : Theme.of(context)
                            .primaryTextTheme
                            .titleLarge!
                            .copyWith(
                              color: Colors.yellow,
                            ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                  child: VerticalDivider(
                    color: Colors.white,
                    width: 20,
                    // thickness: 3,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isExpense = true;
                    });
                  },
                  child: Text(
                    'Expense',
                    style: !isExpense
                        ? Theme.of(context)
                            .primaryTextTheme
                            .titleLarge!
                            .copyWith(
                                fontWeight: FontWeight.normal, fontSize: 18)
                        : Theme.of(context)
                            .primaryTextTheme
                            .titleLarge!
                            .copyWith(color: Colors.yellow),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 150,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.grey[300]!.withOpacity(0.15),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.grey,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  // vertical: 5,
                  horizontal: 10,
                ),
                child: TextField(
                  controller: _controller,
                  style:
                      Theme.of(context).primaryTextTheme.titleLarge!.copyWith(
                            fontSize: 16,
                          ),
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.done,
                  maxLines: 4,
                  maxLength: 25,
                  decoration: InputDecoration(
                    hintStyle:
                        Theme.of(context).primaryTextTheme.titleLarge!.copyWith(
                              fontSize: 16,
                            ),
                    counterStyle:
                        Theme.of(context).primaryTextTheme.titleLarge!.copyWith(
                              fontSize: 16,
                            ),
                    hintText: "Add Note",
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return StatefulBuilder(builder: (context, setState) {
                            return AlertDialog(
                              backgroundColor: Colors.blueGrey[900],
                              title: Text(
                                'SELECT CATEGORY',
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .titleLarge,
                              ),
                              content: Row(
                                children:
                                    List.generate(categories.length, (index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: GestureDetector(
                                      onTap: () {
                                        dataProvider
                                            .setCategory(categories[index]);
                                        setState(() {});
                                      },
                                      child: SizedBox(
                                        height: 80,
                                        child: Column(
                                          children: [
                                            Icon(
                                              categories[index].icon,
                                              color: dataProvider.category ==
                                                      categories[index]
                                                  ? Colors.yellow
                                                  : themeProvider.isDark
                                                      ? Colors.grey
                                                      : Colors.black,
                                              size: dataProvider.category ==
                                                      categories[index]
                                                  ? 30
                                                  : 24,
                                            ),
                                            Text(
                                              categories[index].catName,
                                              style: Theme.of(context)
                                                  .primaryTextTheme
                                                  .titleLarge!
                                                  .copyWith(
                                                      fontSize: 16,
                                                      color: dataProvider
                                                                  .category ==
                                                              categories[index]
                                                          ? Colors.yellow
                                                          : null),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            );
                          });
                        });
                  },
                  child: Container(
                    height: 70,
                    width: MediaQuery.of(context).size.width / 2 - 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: Colors.grey,
                      ),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.category_rounded,
                            color: themeProvider.isDark
                                ? Colors.grey
                                : Colors.black,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Category',
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .titleLarge,
                              ),
                              Text(
                                dataProvider.category.catName,
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .titleLarge!
                                    .copyWith(
                                      color: Colors.yellow,
                                      fontSize: 12,
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2040),
                    ).then((value) {
                      setState(() {
                        _selectedDate = value!;
                      });
                    });
                  },
                  child: Container(
                    height: 70,
                    width: MediaQuery.of(context).size.width / 2 - 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: Colors.grey,
                      ),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.date_range,
                            color: themeProvider.isDark
                                ? Colors.grey
                                : Colors.black,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Date',
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .titleLarge,
                              ),
                              Text(
                                DateFormat('dd MMMM,yyyy')
                                    .format(_selectedDate),
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .titleLarge!
                                    .copyWith(
                                      color: Colors.yellow,
                                      fontSize: 12,
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 80,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.grey),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Text(
                        '\$',
                        style: Theme.of(context)
                            .primaryTextTheme
                            .titleLarge!
                            .copyWith(color: Colors.yellow, fontSize: 30),
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                      Text(
                        amt,
                        style: Theme.of(context)
                            .primaryTextTheme
                            .titleLarge!
                            .copyWith(fontSize: 40),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 1.5,
                crossAxisCount: 3,
                mainAxisSpacing: 5,
                crossAxisSpacing: 10,
                // mainAxisSpacing: 10,
              ),
              itemCount: 12,
              itemBuilder: (context, index) {
                if (index < 9)
                  return GestureDetector(
                      onTap: () {
                        setState(() {
                          amt += (index + 1).toString();
                        });
                      },
                      child: DialPad(num: (index + 1).toString()));
                if (index == 9)
                  return GestureDetector(
                      onTap: () {
                        setState(() {
                          amt += ".";
                        });
                      },
                      child: DialPad(num: '.'));
                if (index == 10)
                  return GestureDetector(
                      onTap: () {
                        setState(() {
                          amt += "0";
                        });
                      },
                      child: DialPad(num: '0'));
                if (index == 11)
                  return GestureDetector(
                      onTap: () {
                        setState(() {
                          if (amt.length > 0) {
                            int len = amt.length;
                            setState(() {
                              amt = amt.substring(0, len - 1);
                            });
                          }
                        });
                      },
                      child: DialPad(num: '⬅'));
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DialPad extends StatelessWidget {
  final String num;
  const DialPad({
    required this.num,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 0,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey),
      ),
      child: Center(
        child: Text(
          num,
          style: Theme.of(context)
              .primaryTextTheme
              .titleLarge!
              .copyWith(fontSize: 30),
        ),
      ),
    );
  }
}
