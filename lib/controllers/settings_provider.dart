// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../helpers/db_helper.dart';
import '../models/settings_model.dart';

class SettingsProvider extends ChangeNotifier {
  // late SharedPreferences  prefs;
  String currentTheme = 'system';

  List<SettingsModel> _settings = [];

  List<SettingsModel> get settings {
    return [..._settings];
  }

  ThemeMode get themeMode {
    if (currentTheme == 'light'){
      return ThemeMode.light;
    }else if (currentTheme == 'dark'){
      return ThemeMode.dark;
    } else {
      return ThemeMode.system;
    }
  }

  changeTheme(String theme){
    currentTheme = theme;
    notifyListeners();
  } 
  // bool isDarkMode = false;

  // void updateTheme() {
  //   isDarkMode = !isDarkMode;
  //   notifyListeners();
  // }

  void toggle(_switchStat) {
    print('Switch before it toggles: $_switchStat');
    _switchStat = !_switchStat;
    print('Switch after it toggles: $_switchStat');
    updateDarkMode(_switchStat);
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

  Future<void> updateDarkMode(bool switchStat) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('Switch before save updateSettings: $switchStat');
    await prefs.setBool('darkMode', switchStat);
    _settings[0].isDarkMode = switchStat;
    print('Update Settings');
    notifyListeners();
  }

  Future<void> saveSettings(SettingsModel settings) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('url', settings.url);
    await prefs.setBool('darkMode', settings.isDarkMode);
    final settingsList = [
      SettingsModel(
        url: settings.url,
        isDarkMode: settings.isDarkMode,
      ),
    ];
    _settings = settingsList;
    print('Saved Settings');
    notifyListeners();
  }

  Future<void> getSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final url = prefs.getString('url') ?? '';
    final isDarkMode = prefs.getBool('darkMode') ?? false;
    final settingsList = [
      SettingsModel(
        url: url,
        isDarkMode: isDarkMode,
      ),
    ];
    _settings = settingsList;
    print('Load Settings');
    notifyListeners();
  }
  // Future<void> fetchSettings() async {
  //   final dataList = await DBHelper.getData('setting');
  //   if (dataList.isNotEmpty)  {
  //   _settings = dataList
  //       .map(
  //         (setting) => SettingsModel(
  //           id: setting['id'] as int,
  //           setting: setting['setting'] as String?,
  //           active: setting['active'] as int?,
  //         ),
  //       )
  //       .toList();
  //   } else {
  //     addSettings(0, 'darkMode', 0);
  //     addSettings(1, 'screenOn', 0);
  //     addSettings(2, 'buttonFeedback', 0);

  //   }
  //   notifyListeners();
  // }

  // Future<void> addSettings(
  //   int id,
  //   String settings,
  //   int active,
  // ) async {
  //   final newSetting = SettingsModel(
  //     id: id,
  //     setting: settings,
  //     active: active,
  //   );
  //   _settings.add(newSetting);
  //   notifyListeners();
  //   DBHelper.insert('setting', {
  //     'id': newSetting.id,
  //     'setting': newSetting.setting,
  //     'active': newSetting.active,
  //   });
  //   fetchSettings();
  // }

}
