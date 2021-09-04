import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:get/get.dart';
import '../helpers/db_helper.dart';
import '../models/settings_model.dart';

class SettingsController extends GetxController {
  List<SettingsModel> settings = [];
  // String _version = '';

  // List<SettingsModel> get settings {
  //   return [..._settings];
  // }

  getVersionNumber() async {
    // Gets version from pubspec.yaml requires package_info_plus package
    PackageInfo packageInfo =  await PackageInfo.fromPlatform();
    String appVersion = packageInfo.version;
    String appBuild = packageInfo.buildNumber;
    String appName = packageInfo.appName;
    String version = appName + " " + 'V' + appVersion + " B" + appBuild;
    return version;
  }

  getAppName() async {
    // Gets app name from the name setup when package created
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String appName = packageInfo.appName;
    return appName;
  }

  Future<void> fetchSettings() async {
    final dataList = await DBHelper.getData('app_settings');
    if (dataList.isNotEmpty)  { 
    settings = dataList
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
    // notifyListeners();
  }

  Future<void> addSettings(
    int id,
    String setting,
    int active,
  ) async {
    final newSetting = SettingsModel(
      id: id,
      setting: setting,
      active: active,
    );
    settings.add(newSetting);
    // notifyListeners();
    DBHelper.insert('app_settings', {
      'id': newSetting.id,
      'setting': newSetting.setting,
      'active': newSetting.active,
    });
  }
}
