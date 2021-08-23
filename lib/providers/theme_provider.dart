import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  //
  
  bool isDarkMode = false;

  void updateTheme() {
    isDarkMode = !isDarkMode;
    notifyListeners();
  }
}
