import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// This Model is the layout of each individual item in the state.

class MatchModel with ChangeNotifier {
  final String id;
  final String? matchName;
  final String player1Name;
  final String player2Name;
  final List playerNameList;
  final String? player4Name;
  final String? player5Name;
  final String? player6Name;
  final String? player7Name;
  final String? player8Name;
  final String? player9Name;
  final String? player10Name;
  final String player1Id;
  final String player2Id;
  final List playerIdList;
  final int? player4Id;
  final int? player5Id;
  final int? player6Id;
  final int? player7Id;
  final int? player8Id;
  final int? player9Id;
  final int? player10Id;
  final int player1Score;
  final int player2Score;
  final List playerScoreList;
  final int? player4Score;
  final int? player5Score;
  final int? player6Score;
  final int? player7Score;
  final int? player8Score;
  final int? player9Score;
  final int? player10Score;
  final int player1Color;
  final int player2Color;
  final List playerColorList;
  final int? player4Color;
  final int? player5Color;
  final int? player6Color;
  final int? player7Color;
  final int? player8Color;
  final int? player9Color;
  final int? player10Color;
  final String gameName;
  final int? gameId;
  final String winner;
  final int winnerId;
  final int winScore;
  final bool lowScore;
  final int dateTime;
  final bool isComplete;
  final bool isSelected;
  final bool freePlay;

  MatchModel({
    this.id = "_",
    this.matchName,
    required this.player1Name,
    required this.player2Name,
    this.playerNameList = const [],
    this.player4Name,
    this.player5Name,
    this.player6Name,
    this.player7Name,
    this.player8Name,
    this.player9Name,
    this.player10Name,
    this.player1Id = "",
    this.player2Id = "",
    this.playerIdList = const [],
    this.player4Id,
    this.player5Id,
    this.player6Id,
    this.player7Id,
    this.player8Id,
    this.player9Id,
    this.player10Id,
    this.player1Score=0,
    this.player2Score=0,
    this.playerScoreList = const [],
    this.player4Score,
    this.player5Score,
    this.player6Score,
    this.player7Score,
    this.player8Score,
    this.player9Score,
    this.player10Score,
    this.player1Color=0,
    this.player2Color=0,
    this.playerColorList = const [],
    this.player4Color,
    this.player5Color,
    this.player6Color,
    this.player7Color,
    this.player8Color,
    this.player9Color,
    this.player10Color,
    this.gameName = "_",
    this.gameId,
    this.winner = "",
    this.winnerId = 0,
    this.winScore = 0,
    this.lowScore = false,
    this.dateTime = 0,
    this.isComplete = false,
    this.isSelected = false,
    this.freePlay = false,
  });
}
