import 'package:flutter/foundation.dart';

class SettingsModel with ChangeNotifier {
  final int id;
  final String? setting;
  final int? active;

  SettingsModel({
    this.id=0,
    this.setting,
    this.active,
  });
}
