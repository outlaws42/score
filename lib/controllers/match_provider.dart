import 'package:flutter/material.dart';
import '../helpers/db_helper.dart';
import '../models/match_model.dart';

class MatchProvider extends ChangeNotifier {
  List<MatchModel> _matches = [];
  List<MatchModel> _matchesSingle = [];

  List<MatchModel> get match {
    return [..._matches];
  }
  List<MatchModel> get matchSingle {
    return [..._matchesSingle];
  }

  void plus({
    id,
    score,
    player,
    addAmount,
  }) {
    score += addAmount;
    print(score);
    updateScore(id, score, player);
    // fetchMatch();
    // notifyListeners();
  }

  void minus({
    id,
    score,
    player,
    minusAmount,
  }) {
    score -= minusAmount;
    print(score);
    updateScore(id, score, player);
    // fetchMatch();
    // notifyListeners();
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
            player1Name: match['player1_name'] as String,
            player2Name: match['player2_name'] as String,
            player1Id: match['player1_id'] as int?,
            player2Id: match['player2_id'] as int?,
            // playerId3: match['player3_id'] as int?,
            // playerId4: match['player4_id'] as int?,
            // playerId5: match['player5_id'] as int?,
            player1Score: match['player1_score'] as int,
            player2Score: match['player2_score'] as int,
            player1Color: match['player1_color'] as String,
            player2Color: match['player2_color'] as String,
            // playerScore3: match['playerscore3'] as int?,
            // playerScore4: match['playerscore4'] as int?,
            // playerScore5: match['playerscore5'] as int?,
            winner: match['winner'] as String,
            winScore: match['win_score'] as int?,
            lowScore: match['low_score'] == 0 ? false : true,
            isComplete: match['is_complete'] == 0 ? false : true,
          ),
        )
        .toList();
    notifyListeners();
  }

  Future<void> fetchMatchById(int id) async {
    final dataList = await DBHelper.getDataById('indv_matches', id);
    _matchesSingle = dataList
        .map(
          (match) => MatchModel(
            id: match['id'] as int?,
            matchName: match['match_name'] as String?,
            gameName: match['game_name'] as String?,
            gameId: match['game_id'] as int?,
            player1Name: match['player1_name'] as String,
            player2Name: match['player2_name'] as String,
            player1Id: match['player1_id'] as int?,
            player2Id: match['player2_id'] as int?,
            // playerId3: match['player3_id'] as int?,
            // playerId4: match['player4_id'] as int?,
            // playerId5: match['player5_id'] as int?,
            player1Score: match['player1_score'] as int,
            player2Score: match['player2_score'] as int,
            player1Color: match['player1_color'] as String,
            player2Color: match['player2_color'] as String,
            // playerScore3: match['playerscore3'] as int?,
            // playerScore4: match['playerscore4'] as int?,
            // playerScore5: match['playerscore5'] as int?,
            winner: match['winner'] as String,
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
    required String player1Name,
    required String player2Name,
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
      player1Color: "green",
      player2Color: "green",
      winner: "_",
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
      'player1_color': newMatch.player1Color,
      'player2_color': newMatch.player2Color,
      'winner': newMatch.winner,
      'win_score': newMatch.winScore,
      'low_score': newMatch.lowScore == false ? 0 : 1,
      'is_complete': newMatch.isComplete == false ? 0 : 1,
    });
  }

  Future<void> updateScore(
    int id,
    int score,
    String player,
  ) async {
    // final newPlayer = MatchModel(
    //   firstName: faker.person.firstName(),
    //   lastName: faker.person.lastName(),
    //   wins: faker.randomGenerator.integer(20),
    // );
    // _matches.add(newPlayer);
    // notifyListeners();
    if (player == "player1") {
      DBHelper.update('indv_matches', id, {
        'player1_score': score,
      });
    } else {
      DBHelper.update(
        'indv_matches',
        id,
        {
          'player2_score': score,
        },
      );
    }
    fetchMatch();
    notifyListeners();
  }

  Future<void> updateWinner(
    int id,
    String player,
  ) async {
    DBHelper.update('indv_matches', id, {
      'winner': player,
    });
    fetchMatch();
    notifyListeners();
  }
}
