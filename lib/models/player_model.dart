import 'package:flutter/foundation.dart';


class PlayerModel with ChangeNotifier {
  final String id;
  final String name;
  final int wins;
  final int tempScore;
  final int dateTime;
  final bool isSelected;

  PlayerModel({
    this.id = "_",
    this.name = "_",
    this.wins = 0,
    this.tempScore = 0,
    this.isSelected = false,
    this.dateTime = 0,
  });
  // : this.dateTime = dateTime ?? DateTime.now();

  factory PlayerModel.fromJson(Map<String, dynamic> json) {
    return PlayerModel(
      id: json['_id'] as String,
      name: json['name'] as String,
      wins: json['wins'] as int,
      isSelected: json['is_selected'] as bool,
      dateTime:  json['datetime'] as int,
    );
  }
}
