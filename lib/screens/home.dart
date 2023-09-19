import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_manager/utils/bnavbar.dart';
import 'package:provider/provider.dart';

import '../utils/themes.dart';
import '../utils/topbar.dart';
import 'accounts.dart';
import 'analysis.dart';
import 'budgets.dart';
import 'records.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

PageController controller = PageController();

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        centerTitle: false,
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: provider.isDark ? Colors.white : Colors.black,
          ),
          onPressed: () {},
        ),
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          'Money Manager',
          style: Theme.of(context).primaryTextTheme.titleLarge,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: IconButton(
              icon: Icon(
                Icons.sunny,
                color: provider.isDark ? Colors.white : Colors.black,
              ),
              onPressed: () {
                provider.switchTheme();
              },
            ),
          ),
        ],
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(100),
            child: SizedBox(
              height: 100,
              child: TopBar(provider: provider),
            )),
      ),
      bottomNavigationBar: const BNavBar(),
      body: PageView(
        // allowImplicitScrolling: false,
        physics: const NeverScrollableScrollPhysics(),
        controller: controller,
        children: const [
          Records(),
          Analysis(),
          Budgets(),
          Accounts(),
        ],
      ),
    );
  }
}
