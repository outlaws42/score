import 'package:flutter/foundation.dart';

// This Model is the layout of each individual item in the state.

class PlayerModel with ChangeNotifier {
  final int id;
  final String name;
  final int wins;
  final int tempScore;

  PlayerModel({
    this.id = 0,
    this.name = "_",
    this.wins = 0,
    this.tempScore = 0,
  });
}
