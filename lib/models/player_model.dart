import 'package:flutter/foundation.dart';


class PlayerModel with ChangeNotifier {
  final int id;
  final String name;
  final int wins;
  final int tempScore;
  final int dateTime;
  final bool isSelected;

  PlayerModel({
    this.id = 0,
    this.name = "_",
    this.wins = 0,
    this.tempScore = 0,
    this.dateTime = 0,
    this.isSelected = false,
  });
}
