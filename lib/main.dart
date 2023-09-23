import 'package:flutter/material.dart';
import 'package:money_manager/screens/add_transaction_screen.dart';
import 'package:money_manager/services/db_service.dart';
import 'package:money_manager/utils/data_provider.dart';
import 'package:money_manager/utils/database_provider.dart';
import 'package:money_manager/utils/view.dart';
import 'package:provider/provider.dart';

import 'screens/home.dart';
import 'utils/themes.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // await DbHelper().database;
  runApp(const MoneyManager());
}

class MoneyManager extends StatelessWidget {
  const MoneyManager({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => DataProvider()),
        ChangeNotifierProvider(create: (context) => ViewProvider()),
        ChangeNotifierProvider(
          create: (context) => DatabaseProvider(),
        )
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, value, child) {
          return MaterialApp(
            theme: value.currentTheme,
            debugShowCheckedModeBanner: false,
            home: const HomePage(),
            routes: {
              '/add-t': (context) => const AddTransactionScreen(),
            },
          );
        },
      ),
    );
  }
}
