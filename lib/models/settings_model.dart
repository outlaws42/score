import 'package:flutter/foundation.dart';

// This Model is the layout of each individual item in the state.

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
