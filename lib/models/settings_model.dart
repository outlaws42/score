import 'package:flutter/foundation.dart';

class SettingsModel with ChangeNotifier {
  final String url;
  bool isDarkMode;
  // final int? active;

  SettingsModel({
   required this.url,
   required this.isDarkMode,
    // this.active,
  });
}
