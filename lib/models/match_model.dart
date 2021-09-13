import 'package:flutter/foundation.dart';

// This Model is the layout of each individual item in the state.

class MatchModel with ChangeNotifier {
  final int? id;
  final String? matchName;
  final String? player1Name;
  final String? player2Name;
  final int? playerId1;
  final int? playerId2;
  // final int? playerId3;
  // final int? playerId4;
  // final int? playerId5;
  final int? playerScore1;
  final int? playerScore2;
  // final int? playerScore3;
  // final int? playerScore4;
  // final int? playerScore5;
  final String? gameName;
  final int? gameId;
  final int? winScore;
  final bool? lowScore;
  final bool? isComplete;

  MatchModel({
    this.id = 0,
    this.matchName,
    this.player1Name,
    this.player2Name,
    this.playerId1,
    this.playerId2,
    // this.playerId3 = 0,
    // this.playerId4 = 0,
    // this.playerId5 = 0,
    this.playerScore1,
    this.playerScore2,
    // this.playerScore3 = 0,
    // this.playerScore4 = 0,
    // this.playerScore5 = 0,
    this.gameName,
    this.gameId,
    this.winScore,
    this.lowScore,
    this.isComplete = false,
  });
}
