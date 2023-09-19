import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final lightTheme = ThemeData(
  appBarTheme: AppBarTheme(
    backgroundColor: ThemeData.dark().appBarTheme.backgroundColor,
  ),
  primaryColor: const Color(0xffCCCCCC),
  scaffoldBackgroundColor: const Color(0xffF5F5F5),
  colorScheme: const ColorScheme.light(
    error: Color(0xffFF0000),
    secondary: Colors.green,
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: Color(0xff007ACC),
  ),
  highlightColor: const Color(0xffFFD700),
  primaryTextTheme: TextTheme(
    titleLarge: GoogleFonts.notoSerifGeorgian(
      fontWeight: FontWeight.bold,
      fontSize: 20,
      color: const Color(0xff333333),
    ),
  ),
);
final darkTheme = ThemeData(
  primaryColor: const Color(0xff2E3B4E),
  scaffoldBackgroundColor: const Color(0xff121212),
  colorScheme: const ColorScheme.light(
    error: Color(0xffFF0000),
    secondary: Color(0xff009688),
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: Color(0xff009688),
  ),
  highlightColor: const Color(0xffFFC107),
  primaryTextTheme: TextTheme(
    titleLarge: GoogleFonts.notoSerifGeorgian(
      fontWeight: FontWeight.bold,
      fontSize: 20,
      color: const Color(0xffCCCCCC),
    ),
  ),
);

class ThemeProvider with ChangeNotifier {
  ThemeData _selectedTheme = darkTheme;
  bool _isDark = true;

  ThemeData get currentTheme {
    return _selectedTheme;
  }

  bool get isDark {
    return _isDark;
  }

  switchTheme() {
    _isDark = !_isDark;
    if (_isDark) {
      _selectedTheme = darkTheme;
    } else {
      _selectedTheme = lightTheme;
    }
    notifyListeners();
  }
}
