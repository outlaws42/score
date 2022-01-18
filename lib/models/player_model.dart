import 'package:flutter/foundation.dart';
import 'package:objectbox/objectbox.dart';
import 'match_model.dart';

@Entity()
class PlayerModel with ChangeNotifier {
  final int id;
  final String name;
  final int wins;
  final int tempScore;
  final int dateTime;
  final bool isSelected;

  final matches = ToMany<MatchModel>();
  
  PlayerModel({
    this.id = 0,
    this.name = "_",
    this.wins = 0,
    this.tempScore = 0,
    this.dateTime = 0,
    this.isSelected = false,
  });
}
