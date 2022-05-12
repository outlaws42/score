import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// This Model is the layout of each individual item in the state.

class Player {
  late String playerId; 
  late String playerName;
  late int score;
  late int color;

  Player({
    this.playerId="",
    this.playerName="",
    this.score= 0,
    this.color= 0,

  });
   
  Player.fromJson(Map<String, dynamic> json) {
    playerId = json['player_id'] as String;
    playerName = json['player_name'] as String;
    score = json['score'] as int;
    color = json['color'] as int;
  }

  Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['player_id'] = this.playerId;
        data['player_name'] = this.playerName;
        data['score'] = this.score;
        data['color'] = this.color;
        return data;
    }
}

class MatchModel with ChangeNotifier {
  late String id;
  late List<Player> players;
  late String gameName;
  late String gameId;
  late String winner;
  late String winnerId;
  // late int winScore;
  late bool lowScore;
  late int dateTime;
  late bool isComplete;
  late bool isSelected;
  // final bool freePlay;

  MatchModel({
    this.id = "_",
    this.players = const [],
    this.gameName = "_",
    this.gameId= "_",
    this.winner = "",
    this.winnerId = "_",
    // this.winScore = 0,
    this.lowScore = false,
    this.dateTime = 0,
    this.isComplete = false,
    this.isSelected = false,
    // this.freePlay = false,
  });

  MatchModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    if (json['players'] != null) {
      players = <Player>[];
      json['players'].forEach((v) {
        players.add(new Player.fromJson(v));
      });
    }
    gameId = json['game_id'];
    gameName = json['game'];
    winner = json['winner'];
    winnerId = json['winner_id'];
    // winScore = json['win_score'];
    lowScore = json['low_score'];
    isSelected = json['is_selected'];
    isComplete = json['is_complete'];
    dateTime = json['datetime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    // if (this.players != null) {
      data['players'] = this.players.map((v) => v.toJson()).toList();
    // }
    data['game_id'] = this.gameId;
    data['game'] = this.gameName;
    data['winner'] = this.winner;
    data['winner_id'] = this.winnerId;
    // data['win_score'] = this.winScore;
    data['low_score'] = this.lowScore;
    data['is_selected'] = this.isSelected;
    data['is_complete'] = this.isComplete;
    data['datetime'] = this.dateTime;
    return data;
  }

  // factory MatchModel.fromJson(Map<String, dynamic> json) {
  //   return MatchModel(
  //     id: json['_id'] as String,
  //     gameName: json['game'] as String,
  //     gameId: json['game_id'] as String,
      
  //     players: json['players'] as List<Player>,
  //     winner: json['winner'] as String,
  //     winnerId: json['winner_id'] as String,
  //     winScore: json['win_score'] as int,
  //     isComplete: json['is_complete'] as bool,
  //     isSelected: json['is_selected'] as bool,
  //     lowScore: json['low_score'] as bool,
  //     dateTime:  json['datetime'] as int,
  //   );
  // }
}
