import 'package:flutter/foundation.dart';


class PlayerModel with ChangeNotifier {
  final String id;
  late String name;
  late int wins;
  late int matches;
  late int tempScore;
  final int dateTime;
  late bool isSelected;

  PlayerModel({
    this.id = "_",
    this.name = "_",
    this.wins = 0,
    this.matches = 0,
    this.tempScore = 0,
    this.isSelected = false,
    this.dateTime = 0,
  });

  factory PlayerModel.fromJson(Map<String, dynamic> json) {
    return PlayerModel(
      id: json['_id'] as String,
      name: json['name'] as String,
      wins: json['wins'] as int,
      matches: json['matches'] as int,
      isSelected: json['is_selected'] as bool,
      dateTime:  json['datetime'] as int,
    );
  }
}
