import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:money_manager/screens/home.dart';
import 'package:money_manager/utils/themes.dart';
import 'package:provider/provider.dart';

class BNavBar extends StatefulWidget {
  const BNavBar({super.key});

  @override
  State<BNavBar> createState() => _BNavBarState();
}

int index = 0;

class _BNavBarState extends State<BNavBar> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return BottomNavigationBar(
      showSelectedLabels: true,
      selectedLabelStyle:
          Theme.of(context).primaryTextTheme.titleLarge!.copyWith(fontSize: 14),
      unselectedLabelStyle:
          Theme.of(context).primaryTextTheme.titleLarge!.copyWith(fontSize: 14),
      currentIndex: index,
      onTap: (ind) {
        setState(() {
          index = ind;
        });
        log(index.toString());
        controller.animateToPage(index,
            duration: const Duration(
              milliseconds: 100,
            ),
            curve: Curves.linear);
      },
      selectedIconTheme: const IconThemeData(
        color: Color(0xffffe84f),
      ),
      showUnselectedLabels: true,
      selectedItemColor: const Color(0xffffe84f),
      items: [
        BottomNavigationBarItem(
          backgroundColor: themeProvider.isDark
              ? Colors.blueGrey[900]
              : Colors.blueGrey[800],
          icon: Icon(
            Icons.receipt,
            color: Colors.white,
          ),
          label: 'Records',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.pie_chart,
            color: Colors.white,
          ),
          label: 'Analysis',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.calculate,
            color: Colors.white,
          ),
          label: 'Budgets',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.account_balance,
            color: Colors.white,
          ),
          label: 'Accounts',
        ),
      ],
    );
  }
}
