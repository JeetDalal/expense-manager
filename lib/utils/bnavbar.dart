import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:money_manager/screens/home.dart';

class BNavBar extends StatefulWidget {
  const BNavBar({super.key});

  @override
  State<BNavBar> createState() => _BNavBarState();
}

int index = 0;

class _BNavBarState extends State<BNavBar> {
  @override
  Widget build(BuildContext context) {
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
      showUnselectedLabels: true,
      selectedItemColor: const Color(0xffffe84f),
      items: [
        BottomNavigationBarItem(
          backgroundColor: Colors.blueGrey[900],
          icon: Icon(
            Icons.receipt,
          ),
          label: 'Records',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.pie_chart,
          ),
          label: 'Analysis',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.calculate,
          ),
          label: 'Budgets',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.account_balance,
          ),
          label: 'Accounts',
        ),
      ],
    );
  }
}
