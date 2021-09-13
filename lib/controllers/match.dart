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
            matchName: match['matchname'] as String?,
            player1Name: match['player1_name'] as String?,
            player2Name: match['player1_name'] as String?,
            playerId1: match['player1_id'] as int?,
            playerId2: match['player2_id'] as int?,
            // playerId3: match['player3_id'] as int?,
            // playerId4: match['player4_id'] as int?,
            // playerId5: match['player5_id'] as int?,
            playerScore1: match['player_score1'] as int?,
            playerScore2: match['player_score2'] as int?,
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
    String matchname = "",
    String? player1Name,
    String? player2Name,
    int? player1Id,
    int? player2Id,
    int? endscore,
    int playerscore1 = 0,
    int playerscore2 = 0,
    String? gameName,
    int? gameid,
    bool iscompleted = false,
  }) async {
    final newMatch = MatchModel(
      // id: id,
      matchName: matchname,
      playerScore1: playerscore1,
      playerScore2: playerscore2,
      isComplete: iscompleted,
    );
    _matches.add(newMatch);
    notifyListeners();
    DBHelper.insert('indv_matches', {
      // 'id': newPlayer.id,
      'matchname': newMatch.matchName,
      'iscomplete': newMatch.isComplete,
      'playerscore1': newMatch.playerScore1,
      'playerscore2': newMatch.playerScore2,
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
