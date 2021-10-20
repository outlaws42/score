import 'package:flutter/foundation.dart';


class GameModel with ChangeNotifier {
  final int id;
  final String name;
  final String description;
  final int? endScore;
  final bool lowScore;
  final bool freePlay;
  final bool isSelected;
  int dateTime;

  GameModel({
    this.id=0,
    this.name ="game",
    this.description = 'This game will test you',
    this.endScore,
    this.lowScore = false,
    this.freePlay = false,
    this.isSelected = false,
    this.dateTime = 0,
  });
}
