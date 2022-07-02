import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './init_global_providers.dart';

class AppThemeProvider extends ChangeNotifier {
  
  final SharedPreferences _sharedPreferences;

  AppThemeProvider(this._sharedPreferences);
  
  String currentTheme = 'system';

  // bool get isTheme {
  //   return currentTheme != null;
  // }

  ThemeMode get themeMode {
    if (currentTheme == 'light'){
      return ThemeMode.light;
    }else if (currentTheme == 'dark'){
      return ThemeMode.dark;
    } else {
      return ThemeMode.system;
    }
  }

  Future changeTheme(String theme) async {
    // SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _sharedPreferences.setString('theme', theme);
    currentTheme = theme;
    notifyListeners();
  } 

  Future intialize() async {
    // SharedPreferences _prefs = await SharedPreferences.getInstance();
    currentTheme = _sharedPreferences.getString('theme') ?? 'system';
    notifyListeners();
  }


}
