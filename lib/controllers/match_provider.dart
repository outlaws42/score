import 'package:flutter/material.dart';
import '../helpers/db_helper.dart';
import '../models/match_model.dart';

class MatchProvider extends ChangeNotifier {
  List<MatchModel> _matches = [];
  List<MatchModel> _matchesWins = [];

  List<MatchModel> get match {
    return [..._matches];
  }

  List<MatchModel> get matchWins {
    return [..._matchesWins];
  }

  void changeTileColor({
    required Color color,
    required int playerIndex,
    required String player,
    required int id,
  }) {
    int colorInt = color.value;
    updateColor(
      id: id,
      color: colorInt,
      playerIndex: playerIndex,
      player: player,
    );
  }

  void changeCompleteStatus(matchId, _isComplete) {
    _isComplete = !_isComplete;
    int isCompleteInt = _isComplete == false ? 0 : 1;
    updateIsComplete(matchId, isCompleteInt);
  }

  void plus({
    id,
    score,
    playerIndex,
    player,
    addAmount,
  }) {
    score += addAmount;
    updateScore(
      id,
      score,
      playerIndex,
      player,
    );
  }

  void minus({
    id,
    score,
    playerIndex,
    player,
    minusAmount,
  }) {
    if (score != 0) {
      score -= minusAmount;
      updateScore(
        id,
        score,
        playerIndex,
        player,
      );
    }
  }

  void filtereList() {
    _matchesWins =
        _matches.where((win) => win.winner.contains('Cara')).toList();
    notifyListeners();
  }

  void updateSelected({required int matchId, required bool isSelected}) {
    isSelected = !isSelected;
    int isSelectedInt = isSelected == false ? 0 : 1;
    updateIsSelected(matchId, isSelectedInt);
  }

  Future<void> fetchMatch() async {
    final dataList = await DBHelper.getData('player_match');
    _matches = dataList
        .map(
          (match) => MatchModel(
            id: match['id'] as int,
            matchName: match['match_name'] as String?,
            gameName: match['game_name'] as String,
            gameId: match['game_id'] as int?,
            player1Name: match['player1_name'] as String,
            player2Name: match['player2_name'] as String,
            playerNameList: [
              match['player1_name'],
              match['player2_name'],
              match['player3_name'],
              match['player4_name'],
              match['player5_name'],
              match['player6_name'],
              match['player7_name'],
              match['player8_name'],
              match['player9_name'],
              match['player10_name'],
            ],
            // player4Name: match['player4_name'] as String?,
            // player5Name: match['player5_name'] as String?,
            // player6Name: match['player6_name'] as String?,
            // player7Name: match['player7_name'] as String?,
            // player8Name: match['player8_name'] as String?,
            // player9Name: match['player9_name'] as String?,
            // player10Name: match['player10_name'] as String?,
            // player1Id: match['player1_id'] as int,
            // player2Id: match['player2_id'] as int,
            playerIdList: [
              match['player1_id'],
              match['player2_id'],
              match['player3_id'],
              match['player4_id'],
              match['player5_id'],
              match['player6_id'],
              match['player7_id'],
              match['player8_id'],
              match['player9_id'],
              match['player10_id'],
            ],
            // player4Id: match['player4_id'] as int?,
            // player5Id: match['player5_id'] as int?,
            // player6Id: match['player6_id'] as int?,
            // player7Id: match['player7_id'] as int?,
            // player8Id: match['player8_id'] as int?,
            // player9Id: match['player9_id'] as int?,
            // player10Id: match['player10_id'] as int?,
            player1Score: match['player1_score'] as int,
            player2Score: match['player2_score'] as int,
            playerScoreList: [
              match['player1_score'],
              match['player2_score'],
              match['player3_score'],
              match['player4_score'],
              match['player5_score'],
              match['player6_score'],
              match['player7_score'],
              match['player8_score'],
              match['player9_score'],
              match['player10_score'],
            ],
            // player4Score: match['player4_score'] as int?,
            // player5Score: match['player5_score'] as int?,
            // player6Score: match['player6_score'] as int?,
            // player7Score: match['player7_score'] as int?,
            // player8Score: match['player8_score'] as int?,
            // player9Score: match['player9_score'] as int?,
            // player10Score: match['player10_score'] as int?,
            player1Color: match['player1_color'] as int,
            player2Color: match['player2_color'] as int,
            playerColorList: [
              match['player1_color'],
              match['player2_color'],
              match['player3_color'],
              match['player4_color'],
              match['player5_color'],
              match['player6_color'],
              match['player7_color'],
              match['player8_color'],
              match['player9_color'],
              match['player10_color'],
            ],
            // player4Color: match['player4_color'] as int?,
            // player5Color: match['player5_color'] as int?,
            // player6Color: match['player6_color'] as int?,
            // player7Color: match['player7_color'] as int?,
            // player8Color: match['player8_color'] as int?,
            // player9Color: match['player9_color'] as int?,
            // player10Color: match['player10_color'] as int?,
            winnerId: match['winner_id'] as int,
            winner: match['winner'] as String,
            winScore: match['win_score'] as int,
            dateTime: match['date_time'] as int,
            lowScore: match['low_score'] == 0 ? false : true,
            freePlay: match['free_play'] == 0 ? false : true,
            isComplete: match['is_complete'] == 0 ? false : true,
            isSelected: match['is_selected'] == 0 ? false : true,
          ),
        )
        .toList();
    notifyListeners();
  }

  // Future<void> fetchMatchByWinnerId({
  //   required int winnerId,
  // }) async {
  //   final dataList = await DBHelper.getDataByWinnerId('player_match', winnerId);
  //   _matchesWins = dataList
  //       .map(
  //         (match) => MatchModel(
  //           id: match['id'] as int,
  //           matchName: match['match_name'] as String?,
  //           gameName: match['game_name'] as String,
  //           gameId: match['game_id'] as int?,
  //           player1Name: match['player1_name'] as String,
  //           player2Name: match['player2_name'] as String,
  //           player1Id: match['player1_id'] as int,
  //           player2Id: match['player2_id'] as int,
  //           // playerId3: match['player3_id'] as int?,
  //           // playerId4: match['player4_id'] as int?,
  //           // playerId5: match['player5_id'] as int?,
  //           player1Score: match['player1_score'] as int,
  //           player2Score: match['player2_score'] as int,
  //           player1Color: match['player1_color'] as int,
  //           player2Color: match['player2_color'] as int,
  //           // playerScore3: match['playerscore3'] as int?,
  //           // playerScore4: match['playerscore4'] as int?,
  //           // playerScore5: match['playerscore5'] as int?,
  //           winnerId: match['winner_id'] as int,
  //           winner: match['winner'] as String,
  //           winScore: match['win_score'] as int,
  //           dateTime: match['date_time'] as int,
  //           lowScore: match['low_score'] == 0 ? false : true,
  //           freePlay: match['free_play'] == 0 ? false : true,
  //           isComplete: match['is_complete'] == 0 ? false : true,
  //         ),
  //       )
  //       .toList();
  //   notifyListeners();
  // }

  Future<void> addMatch({
    // int id,
    String matchName = "",
    String gameName = "",
    int? gameId,
    required String player1Name,
    required String player2Name,
    int player1Id = 0,
    int player2Id = 0,
    // int player1Score = 0,
    // int player2Score = 0,
    // required List playerNameList,
    // required List playerIdList,
    // required List playerScoreList,
    // required List playerColorList,
    int endScore = 0,
    int dateTime = 0,
    bool lowScore = false,
    bool freePlay = false,
    bool isCompleted = false,
    bool isSelected = false,
  }) async {
    final newMatch = MatchModel(
      // id: id,
      matchName: matchName,
      gameName: gameName,
      gameId: gameId,
      player1Name: player1Name,
      player2Name: player2Name,
      // playerNameList: playerNameList,
      // playerIdList: playerIdList,
      // playerScoreList: [],
      // playerColorList: playerColorList,
      player1Id: player1Id,
      player2Id: player2Id,
      player1Score: 0,
      player2Score: 0,
      player1Color: 4282339765,
      player2Color: 4278228616,
      winner: "_",
      winnerId: 0,
      dateTime: dateTime,
      winScore: endScore,
      lowScore: lowScore,
      freePlay: freePlay,
      isComplete: isCompleted,
      isSelected: isSelected,
    );
    _matches.add(newMatch);
    notifyListeners();
    // var numberPlayers = newMatch.playerIdList.length;
    DBHelper.insert('player_match', {
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
      'winner_id': newMatch.winnerId,
      'winner': newMatch.winner,
      'win_score': newMatch.winScore,
      'date_time': newMatch.dateTime,
      'low_score': newMatch.lowScore == false ? 0 : 1,
      'free_play': newMatch.freePlay == false ? 0 : 1,
      'is_complete': newMatch.isComplete == false ? 0 : 1,
      'is_selected': newMatch.isSelected == false ? 0 : 1,
    });
  }

  // Future<void> updateScore(
  //   int id,
  //   int score,
  //   String player,
  // ) async {
  //   if (player == "player1") {
  //     DBHelper.update('player_match', id, {
  //       'player1_score': score,
  //     });
  //   } else {
  //     DBHelper.update(
  //       'player_match',
  //       id,
  //       {
  //         'player2_score': score,
  //       },
  //     );
  //   }
  //   fetchMatch();
  //   notifyListeners();
  // }

  Future<void> updateScore(
    int id,
    int score,
    int playerIndex,
    String player,
  ) async {
    int playerNumber = playerIndex + 1;
    print('This is the player number $playerNumber');
    DBHelper.update(
      'player_match',
      id,
      {
        'player${playerNumber}_score': score,
      },
    );
    fetchMatch();
    notifyListeners();
  }

  // Future<void> updateColor(
  //   int id,
  //   int color,
  //   String player,
  // ) async {
  //   if (player == "player1") {
  //     DBHelper.update('player_match', id, {
  //       'player1_color': color,
  //     });
  //   } else {
  //     DBHelper.update(
  //       'player_match',
  //       id,
  //       {
  //         'player2_color': color,
  //       },
  //     );
  //   }
  //   fetchMatch();
  //   notifyListeners();
  // }

  Future<void> updateColor({
    required int id,
    required int color,
    required int playerIndex,
    required String player,
  }) async {
    int playerNumber = playerIndex + 1;
    // if (player == "player1") {
    DBHelper.update('player_match', id, {
      'player${playerNumber}_color': color,
    });
    // } else {
    //   DBHelper.update(
    //     'player_match',
    //     id,
    //     {
    //       'player2_color': color,
    //     },
    //   );
    // }
    fetchMatch();
    notifyListeners();
  }

  Future<void> updateIsSelected(
    int matchId,
    int isSelected,
  ) async {
    DBHelper.update('player_match', matchId, {
      'is_selected': isSelected,
    });
    fetchMatch();
    notifyListeners();
  }

  Future<void> deleteMatch(
    int id,
  ) async {
    DBHelper.remove(
      'player_match',
      id,
    );
    fetchMatch();
    notifyListeners();
  }

  Future<void> updateWinner({
    required int matchId,
    required int winnerId,
    required String winnerName,
  }) async {
    DBHelper.update('player_match', matchId, {
      'winner': winnerName,
      'winner_id': winnerId,
      'is_complete': 1,
    });
    fetchMatch();
    notifyListeners();
  }

  Future<void> updateIsComplete(
    int matchId,
    int isComplete,
  ) async {
    DBHelper.update('player_match', matchId, {
      'is_complete': isComplete,
    });
    fetchMatch();
    notifyListeners();
  }
}
