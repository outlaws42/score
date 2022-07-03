import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SettingsProvider extends ChangeNotifier {
  String currentTheme = 'system';

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
