import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  String currentTheme = 'system';

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
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setString('theme', theme);
    currentTheme = theme;
    notifyListeners();
  } 

  intialize() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    currentTheme = _prefs.getString('theme') ?? 'system';
    notifyListeners();
  }

  Future<String> getVersionNumber() async {
    // Gets version from pubspec.yaml requires package_info_plus package
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String appVersion = packageInfo.version;
    return appVersion;
  }

  Future<String> getAppName() async {
    // Gets app name from the name setup when package created
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String appName = packageInfo.appName;
    return appName;
  }

}
