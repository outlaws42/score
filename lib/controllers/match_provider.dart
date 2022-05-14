import 'dart:convert';
import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
// import 'package:path/path.dart';
// import '../helpers/db_helper.dart';
import '../models/match_model.dart';
// import '../controllers/player_provider.dart';
// import '../controllers/providers.dart';

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
    String baseName = '192.168.1.9',
    String portName = '3000',
    String currentName = 'matches',
  }) async {
    final url = Uri.parse('http://$baseName:$portName/score_api/$currentName');
    final response = await http.get(url);
    // print(response.body);
    final List<MatchModel> loadCurrent = [];
    final json = jsonDecode(response.body);
    // final test = PlayerModel.fromJson(json);
    if (json != null) {
      json.forEach((value) {
        loadCurrent.add(MatchModel.fromJson(value));
      });
    }
    _matches = loadCurrent;
    notifyListeners();
  }

   Future<void> addMatchHttp(
      {String baseName = '192.168.1.9',
      String portName = '3000',
      String currentName = 'add_match',
      required String gameName,
      required List players}) async {
    final url = Uri.parse('http://$baseName:$portName/score_api/$currentName');
    await http
        .post(
      url,
      body: jsonEncode({'game': gameName, 'players': players}),
    );

      // print('response body: ${jsonDecode(response.body)}');
      await fetchMatch();
      notifyListeners();

    // notifyListeners();
  }

  Future<void> updateScore(
    String id,
    int score,
    int playerIndex,
    String player,
  ) async {
    int matchIndex = getMatchIndex(id);

    String playerId = _matches[matchIndex].players[playerIndex].playerId;
    _matches[matchIndex].players[playerIndex].score = score;

    updateMatch(
      id: id,
      playerId: playerId,
      number: score,
      type: 'score',
    );
    notifyListeners();
  }

  Future<void> updateColor({
    required String id,
    required int color,
    required int playerIndex,
    required String player,
  }) async {
    int matchIndex = getMatchIndex(id);
    String playerId = _matches[matchIndex].players[playerIndex].playerId;
    _matches[matchIndex].players[playerIndex].color = color;
    updateMatch(
      id: id,
      playerId: playerId,
      number: color,
      type: 'color',
    );
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
    int matchIndex = getMatchIndex(matchId);
    _matches[matchIndex].winner = winnerName;
    _matches[matchIndex].winnerId = winnerId;
    _matches[matchIndex].isComplete = true;
    updateMatch(
      id: matchId,
      text: winnerId,
      text2: winnerName,
      toggle: true,
      type: 'winner',
    );
    notifyListeners();
  }

  Future<void> updateIsComplete(
    String matchId,
    int isComplete,
  ) async {
    // DBHelper.update('player_match', matchId, {
    //   'is_complete': isComplete,
    // });
    notifyListeners();
  }

  getMatchIndex(String matchId) {
    return _matches.indexWhere((element) => element.id == matchId);
  }

  Future<void> updateMatch({
    String baseName = '192.168.1.9',
    String portName = '3000',
    String currentName = 'update_match',
    required String id,
    required String type,
    String playerId = "_",
    int number = 0,
    String text = "_",
    String text2 = "_",
    bool toggle = false,
  }) async {
    final url = Uri.parse('http://$baseName:$portName/score_api/$currentName');
    http
        .post(
      url,
      body: jsonEncode({
        '_id': id,
        'playerId': playerId,
        'number': number,
        'toggle': toggle,
        'text': text,
        'text2': text2,
        'type': type
      }),
    )
        .then((response) {
      print('response body: ${jsonDecode(response.body)}');
    });
    notifyListeners();
  }
}
