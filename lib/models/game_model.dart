import 'package:flutter/foundation.dart';

// This Model is the layout of each individual item in the state.

class GameModel with ChangeNotifier {
  final int? id;
  final String? name;
  final String? description;
  final int? endScore;
  final bool lowScore;
  final bool freePlay;
  int dateTime;

  GameModel({
    this.id=0,
    this.name,
    this.description = '',
    this.endScore,
    this.lowScore = false,
    this.freePlay = false,
    this.dateTime = 0,
  });
}
