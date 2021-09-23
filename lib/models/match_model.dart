import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// This Model is the layout of each individual item in the state.

class MatchModel with ChangeNotifier {
  final int? id;
  final String? matchName;
  final String player1Name;
  final String player2Name;
  final int? player1Id;
  final int? player2Id;
  // final int? playerId3;
  // final int? playerId4;
  // final int? playerId5;
  final int player1Score;
  final int player2Score;
  final int player1Color;
  final int player2Color;
  // final int? playerScore3;
  // final int? playerScore4;
  // final int? playerScore5;
  final String? gameName;
  final int? gameId;
  final String winner;
  final int winScore;
  final bool? lowScore;
  final bool isComplete;

  MatchModel({
    this.id = 0,
    this.matchName,
    required this.player1Name,
    required this.player2Name,
    this.player1Id,
    this.player2Id,
    // this.playerId3 = 0,
    // this.playerId4 = 0,
    // this.playerId5 = 0,
    this.player1Score=0,
    this.player2Score=0,
    this.player1Color=0,
    this.player2Color=0,
    // this.playerScore3 = 0,
    // this.playerScore4 = 0,
    // this.playerScore5 = 0,
    this.gameName,
    this.gameId,
    this.winner = "",
    this.winScore = 0,
    this.lowScore,
    this.isComplete = false,
  });
}
