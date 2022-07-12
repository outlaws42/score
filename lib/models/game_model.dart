import 'package:flutter/foundation.dart';


class GameModel with ChangeNotifier {
  final String id;
  late String name;
  late String description;
  late String desUrl;
  final int? endScore;
  late bool lowScore;
  late bool isSelected;
  int dateTime;

  GameModel({
    this.id="_",
    this.name ="game",
    this.description = 'This game will test you',
    this.desUrl = '',
    this.endScore,
    this.lowScore = false,
    this.isSelected = false,
    this.dateTime = 0,
  });

  factory GameModel.fromJson(Map<String, dynamic> json) {
    return GameModel(
      id: json['_id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      desUrl: json['des_url'] as String,
      isSelected: json['is_selected'] as bool,
      lowScore: json['low_score'] as bool,
      dateTime:  json['datetime'] as int,
    );
  }
}
