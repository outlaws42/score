import 'package:flutter/foundation.dart';

// This Model is the layout of each individual item in the state.

class TeamModel with ChangeNotifier {
  final int id;
  final String name;
  final String player1Name;
  final String player2Name;
  final int player1Id;
  final int player2Id;
  final int wins;
  final int tempScore;
  final int dateTime;

  TeamModel({
    this.id = 0,
    this.name = "_",
    this.player1Name ="_",
    this.player2Name ="_",
    this.player1Id = 0,
    this.player2Id = 0,
    this.wins = 0,
    this.tempScore = 0,
    this.dateTime = 0,
  });
}
