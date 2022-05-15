import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../helpers/db_helper.dart';
import '../models/settings_model.dart';

class SettingsProvider extends ChangeNotifier {
  // late SharedPreferences  prefs;
  List<SettingsModel> _settings = [];

  List<SettingsModel> get settings {
    return [..._settings];
  }

  Future<String> getVersionNumber() async {
    // Gets version from pubspec.yaml requires package_info_plus package
    PackageInfo packageInfo =  await PackageInfo.fromPlatform();
    String appVersion = packageInfo.version;
    return appVersion;
  }

  Future<String> getAppName() async {
    // Gets app name from the name setup when package created
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String appName = packageInfo.appName;
    return appName;
  }

  Future<void> fetchSettings() async {
    final dataList = await DBHelper.getData('setting');
    if (dataList.isNotEmpty)  { 
    _settings = dataList
        .map(
          (setting) => SettingsModel(
            id: setting['id'] as int,
            setting: setting['setting'] as String?,
            active: setting['active'] as int?,
          ),
        )
        .toList();
    } else {
      addSettings(0, 'darkMode', 0);
      addSettings(1, 'screenOn', 0);
      addSettings(2, 'buttonFeedback', 0);

    }
    notifyListeners();
  }

  Future<void> addSettings(
    int id,
    String settings,
    int active,
  ) async {
    final newSetting = SettingsModel(
      id: id,
      setting: settings,
      active: active,
    );
    _settings.add(newSetting);
    notifyListeners();
    DBHelper.insert('setting', {
      'id': newSetting.id,
      'setting': newSetting.setting,
      'active': newSetting.active,
    });
    fetchSettings();
  }

}
