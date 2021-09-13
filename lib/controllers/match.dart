import 'package:flutter/material.dart';
import 'package:faker/faker.dart';
import '../helpers/db_helper.dart';
import '../models/match_model.dart';

class MatchProvider extends ChangeNotifier {
  List<MatchModel> _matches = [];

  List<MatchModel> get match {
    return [..._matches];
  }

  Future<void> fetchMatch() async {
    final dataList = await DBHelper.getData('indv_matches');
    _matches = dataList
        .map(
          (match) => MatchModel(
            id: match['id'] as int?,
            matchName: match['match_name'] as String?,
            player1Name: match['player1_name'] as String?,
            player2Name: match['player1_name'] as String?,
            player1Id: match['player1_id'] as int?,
            player2Id: match['player2_id'] as int?,
            // playerId3: match['player3_id'] as int?,
            // playerId4: match['player4_id'] as int?,
            // playerId5: match['player5_id'] as int?,
            player1Score: match['player1_score'] as int?,
            player2Score: match['player2_score'] as int?,
            // playerScore3: match['playerscore3'] as int?,
            // playerScore4: match['playerscore4'] as int?,
            // playerScore5: match['playerscore5'] as int?,
            gameName: match['game_name'] as String?,
            gameId: match['game_id'] as int?,
            winScore: match['win_score'] as int?,
            lowScore: match['low_score'] == 0 ? false : true,
            isComplete: match['is_complete'] == 0 ? false : true,
          ),
        )
        .toList();
    notifyListeners();
  }

  Future<void> addMatch({
    // int id,
    String matchName = "",
    String? player1Name,
    String? player2Name,
    int? player1Id,
    int? player2Id,
    int? endScore,
    int player1Score = 0,
    int player2Score = 0,
    String? gameName,
    int? gameId,
    bool isCompleted = false,
  }) async {
    final newMatch = MatchModel(
      // id: id,
      matchName: matchName,
      player1Name: player1Name,
      player2Name: player2Name,
      player1Id: player1Id,
      player2Id: player2Id,
      player1Score: player1Score,
      player2Score: player2Score,
      winScore: endScore,
      gameName: gameName,
      gameId: gameId,
      isComplete: isCompleted,
    );
    _matches.add(newMatch);
    notifyListeners();
    DBHelper.insert('indv_matches', {
      // 'id': newPlayer.id,
      'match_name': newMatch.matchName,
      'is_complete': newMatch.isComplete,
      'player1_score': newMatch.player1Score,
      'player2_score': newMatch.player2Score,
    });
  }

  // Future<void> addPlayer(
  //   int wins,
  // ) async {
  //   final newPlayer = PlayerModel(
  //     firstName: faker.person.firstName(),
  //     lastName: faker.person.lastName(),
  //     wins: faker.randomGenerator.integer(20),
  //   );
  //   _players.add(newPlayer);
  //   notifyListeners();
  //   DBHelper.insert('players', {
  //     'firstname': newPlayer.firstName,
  //     'lastname': newPlayer.lastName,
  //     'wins': newPlayer.wins,
  //   });
  //   print(newPlayer);
  // }
}
