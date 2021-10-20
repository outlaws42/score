import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// This Model is the layout of each individual item in the state.

class MatchModel with ChangeNotifier {
  final int id;
  final String? matchName;
  final String player1Name;
  final String player2Name;
  final int player1Id;
  final int player2Id;
  final int player1Score;
  final int player2Score;
  final int player1Color;
  final int player2Color;
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
    this.id = 0,
    this.matchName,
    required this.player1Name,
    required this.player2Name,
    this.player1Id = 0,
    this.player2Id = 0,
     this.player1Score=0,
    this.player2Score=0,
    this.player1Color=0,
    this.player2Color=0,
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
