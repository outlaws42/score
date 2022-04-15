import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// This Model is the layout of each individual item in the state.

class MatchModel with ChangeNotifier {
  final String id;
  final List players;
  final String gameName;
  final String gameId;
  final String winner;
  final String winnerId;
  final int winScore;
  final bool lowScore;
  final int dateTime;
  final bool isComplete;
  final bool isSelected;
  // final bool freePlay;

  MatchModel({
    this.id = "_",
    this.players = const [],
    this.gameName = "_",
    this.gameId= "_",
    this.winner = "",
    this.winnerId = "_",
    this.winScore = 0,
    this.lowScore = false,
    this.dateTime = 0,
    this.isComplete = false,
    this.isSelected = false,
    // this.freePlay = false,
  });

  factory MatchModel.fromJson(Map<String, dynamic> json) {
    return MatchModel(
      id: json['_id'] as String,
      gameName: json['game'] as String,
      gameId: json['game_id'] as String,
      players: json['players'] as List,
      winner: json['winner'] as String,
      winnerId: json['winner_id'] as String,
      winScore: json['win_score'] as int,
      isComplete: json['is_complete'] as bool,
      isSelected: json['is_selected'] as bool,
      lowScore: json['low_score'] as bool,
      dateTime:  json['datetime'] as int,
    );
  }
}
