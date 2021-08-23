import 'package:flutter/foundation.dart';

// This Model is the layout of each individual item in the state.

class PlayerModel with ChangeNotifier {
  final int? id;
  final String? firstName;
  final String? lastName;
  final int? wins;

  PlayerModel({
    this.id = 0,
    this.firstName,
    this.lastName,
    this.wins = 0,
  });
}
