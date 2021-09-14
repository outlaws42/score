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
            gameName: match['game_name'] as String?,
            gameId: match['game_id'] as int?,
            player1Name: match['player1_name'] as String?,
            player2Name: match['player2_name'] as String?,
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
    String? gameName,
    int? gameId,
    String? player1Name,
    String? player2Name,
    int? player1Id,
    int? player2Id,
    // int player1Score = 0,
    // int player2Score = 0,
    int? endScore,  
    bool lowScore = false,
    bool isCompleted = false,
  }) async {
    final newMatch = MatchModel(
      // id: id,
      matchName: matchName,
      gameName: gameName,
      gameId: gameId,
      player1Name: player1Name,
      player2Name: player2Name,
      player1Id: player1Id,
      player2Id: player2Id,
      player1Score: 0,
      player2Score: 0,
      winScore: endScore,
      lowScore: lowScore,
      isComplete: isCompleted,
    );
    _matches.add(newMatch);
    notifyListeners();
    DBHelper.insert('indv_matches', {
      // 'id': newPlayer.id,
      'match_name': newMatch.matchName,
      'game_name': newMatch.gameName,
      'game_id': newMatch.gameId,
      'player1_name': newMatch.player1Name,
      'player2_name': newMatch.player2Name,
      'player1_id': newMatch.player1Id,
      'player2_id': newMatch.player2Id,
      'player1_score': newMatch.player1Score,
      'player2_score': newMatch.player2Score,
      'win_score': newMatch.winScore,
      'low_score': newMatch.lowScore== false?0:1,
      'is_complete': newMatch.isComplete== false?0:1,

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
