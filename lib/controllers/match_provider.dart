import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import '../helpers/db_helper.dart';
import '../models/match_model.dart';
import '../controllers/player_provider.dart';
import '../controllers/providers.dart';

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
    required String id,
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

  void updateSelected({required String matchId, required bool isSelected}) {
    isSelected = !isSelected;
    int isSelectedInt = isSelected == false ? 0 : 1;
    updateIsSelected(matchId, isSelectedInt);
  }

  Future<void> fetchMatch({
    String baseName='192.168.1.9',
    String portName='3000',
    String currentName='matches',
  }) async {
    final url = Uri.parse('http://$baseName:$portName/score_api/$currentName');
    final response = await http.get(url);
      // print(response.body);
    final List<MatchModel> loadCurrent = [];
    final json = jsonDecode(response.body);
    // final test = PlayerModel.fromJson(json);
    if (json != null) {
    json.forEach((value){
      loadCurrent.add(
        MatchModel.fromJson(value)
        );

    });
    }
    // print(test);
    // extractedData[0].forEach((value) {
    //     loadCurrent.add(
    //       PlayerModel(
    //         id: value['_id'],
            // dateTime: value['datetime.date'],
    //         isSelected: value['is_selected'],
    //         name: value['name'],
    //         wins: 0,
    //       ),
    //     );
    //   }
    //   );
    // print(loadCurrent);
    _matches = loadCurrent;
    notifyListeners();
  }

  Future<void> addMatchHttp({
    String baseName='192.168.1.9',
    String portName='3000',
    String currentName='add_match',
    required String gameName,
    required List players 
  }) async {

    final url = Uri.parse('http://$baseName:$portName/score_api/$currentName');
    http.post(url, body: jsonEncode({
      'game': gameName,
      'players': players
    }),
    ).then((response){
      // print('This is the response: ${jsonDecode(response.body)}');
    });
    // final newMatch = MatchModel(
    //   gameName: match.gameName,
    //   gameId: match.gameId,
    //   players: match.players,
    //   winner: match.winner,
    //   winnerId: match.winnerId,
    //   winScore: match.winScore,
    //   lowScore: match.lowScore,
    //   dateTime: match.dateTime,
    //   isComplete: false,
    //   isSelected: false
    // );

    notifyListeners();
  }


  // Future<void> addMatch({
  //   // int id,
  //   String matchName = "",
  //   String gameName = "",
  //   String gameId = "",
  //   required String player1Name,
  //   required String player2Name,
  //   String player1Id = "",
  //   String player2Id = "",
  //   // int player1Score = 0,
  //   // int player2Score = 0,
  //   // required List playerNameList,
  //   // required List playerIdList,
  //   // required List playerScoreList,
  //   // required List playerColorList,
  //   int endScore = 0,
  //   int dateTime = 0,
  //   bool lowScore = false,
  //   bool freePlay = false,
  //   bool isCompleted = false,
  //   bool isSelected = false,
  // }) async {
    // final newMatch = MatchModel(
    //   // id: id,
    //   matchName: matchName,
    //   gameName: gameName,
    //   gameId: gameId,
    //   player1Name: player1Name,
    //   player2Name: player2Name,
    //   // playerNameList: playerNameList,
    //   // playerIdList: playerIdList,
    //   // playerScoreList: [],
    //   // playerColorList: playerColorList,
    //   player1Id: player1Id,
    //   player2Id: player2Id,
    //   player1Score: 0,
    //   player2Score: 0,
    //   player1Color: 4282339765,
    //   player2Color: 4278228616,
    //   winner: "_",
    //   winnerId: 0,
    //   dateTime: dateTime,
    //   winScore: endScore,
    //   lowScore: lowScore,
    //   freePlay: freePlay,
    //   isComplete: isCompleted,
    //   isSelected: isSelected,
    // );
    // _matches.add(newMatch);
    // notifyListeners();
    // // var numberPlayers = newMatch.playerIdList.length;
    // DBHelper.insert('player_match', {
    //   // 'id': newPlayer.id,
    //   'match_name': newMatch.matchName,
    //   'game_name': newMatch.gameName,
    //   'game_id': newMatch.gameId,
    //   'player1_name': newMatch.player1Name,
    //   'player2_name': newMatch.player2Name,
    //   'player1_id': newMatch.player1Id,
    //   'player2_id': newMatch.player2Id,
    //   'player1_score': newMatch.player1Score,
    //   'player2_score': newMatch.player2Score,
    //   'player1_color': newMatch.player1Color,
    //   'player2_color': newMatch.player2Color,
    //   'winner_id': newMatch.winnerId,
    //   'winner': newMatch.winner,
    //   'win_score': newMatch.winScore,
    //   'date_time': newMatch.dateTime,
    //   'low_score': newMatch.lowScore == false ? 0 : 1,
    //   'free_play': newMatch.freePlay == false ? 0 : 1,
    //   'is_complete': newMatch.isComplete == false ? 0 : 1,
    //   'is_selected': newMatch.isSelected == false ? 0 : 1,
    // });
  // }

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
    String id,
    int score,
    int playerIndex,
    String player,
  ) async {
    print('playerIndex: $playerIndex');
    print('player: $player');
    print('score: $score');
    print('matchid: $id');
    // print('This is the player number $playerNumber');
    // DBHelper.update(
    //   'player_match',
    //   id,
    //   {
    //     'player${playerNumber}_score': score,
    //   },
    // );
    var matchIndex = _matches.indexWhere((element) => element.id == id);
    print(matchIndex);
    _matches[matchIndex].players[playerIndex].score = score;
    // fetchMatch();
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
    required String id,
    required int color,
    required int playerIndex,
    required String player,
  }) async {
    print('playerIndex: $playerIndex');
    print('player: $player');
    print('color: $color');
    print('matchid: $id');
    // int playerNumber = playerIndex + 1;
    // if (player == "player1") {
    // DBHelper.update('player_match', id, {
    //   'player${playerNumber}_color': color,
    // });
    // } else {
    //   DBHelper.update(
    //     'player_match',
    //     id,
    //     {
    //       'player2_color': color,
    //     },
    //   );
    // }
    // fetchMatch();
    var matchIndex = _matches.indexWhere((element) => element.id == id);
    _matches[matchIndex].players[playerIndex].color = color;
    notifyListeners();
  }

  Future<void> updateIsSelected(
    String matchId,
    int isSelected,
  ) async {
    // DBHelper.update('player_match', matchId, {
    //   'is_selected': isSelected,
    // });
    fetchMatch();
    notifyListeners();
  }

  Future<void> deleteMatch(
    String id,
  ) async {
    // DBHelper.remove(
    //   'player_match',
    //   id,
    // );
    fetchMatch();
    notifyListeners();
  }

  Future<void> updateWinner({
    required String matchId,
    required String winnerId,
    required String winnerName,
  }) async {
    // DBHelper.update('player_match', matchId, {
    //   'winner': winnerName,
    //   'winner_id': winnerId,
    //   'is_complete': 1,
    // });
    int matchIndex = _matches.indexWhere((element) => element.id == matchId);
    _matches[matchIndex].winner = winnerName;
    _matches[matchIndex].winnerId = winnerId;
    _matches[matchIndex].isComplete = true;
    notifyListeners();
  }

  Future<void> updateIsComplete(
    String matchId,
    int isComplete,
  ) async {
    // DBHelper.update('player_match', matchId, {
    //   'is_complete': isComplete,
    // });
    fetchMatch();
    notifyListeners();
  }
}
