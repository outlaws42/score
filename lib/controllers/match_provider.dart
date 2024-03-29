import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/match_model.dart';
import '../helpers.dart';

class MatchProvider extends ChangeNotifier {
  List<MatchModel> _matches = [];
  List<MatchModel> _matchesWins = [];

  List<MatchModel> get match {
    return [..._matches];
  }

  List<MatchModel> get matchWins {
    return [..._matchesWins];
  }

  final String authToken;

  MatchProvider(
    this.authToken,
  );

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
    // int isSelectedInt = isSelected == false ? 0 : 1;
    updateIsSelected(matchId, isSelected);
  }

  Future<void> fetchMatch({
    String currentName = 'matches',
  }) async {
    // SettingsProvider.settings[0].url.toString();
    final url = Uri.parse('$backendUrl/$currentName');
    final response = await http.get(
      url,
      headers: {'x-access-token': authToken},
    );
    final List<MatchModel> loadCurrent = [];
    final json = jsonDecode(response.body);
    if (json != null) {
      json.forEach((value) {
        loadCurrent.add(MatchModel.fromJson(value));
      });
    }
    _matches = loadCurrent;
    notifyListeners();
  }

  Future<void> addMatchHttp(
      {String currentName = 'add_match',
      required String gameName,
      required List players}) async {
    final url = Uri.parse('$backendUrl/$currentName');
    await http.post(
      url,
      headers: {'x-access-token': authToken},
      body: jsonEncode({'game': gameName, 'players': players}),
    );
    await fetchMatch();
    notifyListeners();
  }

  Future<void> copyMatch({
    String currentName = 'copy_match',
    required String id,
  }) async {
    // Sends a post request to the API with id
    // API will return duplicate game ready to play again
    final url = Uri.parse('$backendUrl/$currentName');
    await http.post(
      url,
      headers: {'x-access-token': authToken},
      body: jsonEncode({'_id': id}),
    );
    await fetchMatch();
    notifyListeners();
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
    bool isSelected,
  ) async {
    updateMatch(
      id: matchId,
      toggle: isSelected,
      type: 'isSelected',
    );
    fetchMatch();
    notifyListeners();
  }

  Future<void> deleteMatch({
    String currentName = 'remove_match',
    required String id,
  }) async {
    int matchIndex = getMatchIndex(id);
    _matches.removeAt(matchIndex);
    notifyListeners();
    final url = Uri.parse('$backendUrl/$currentName');
    await http.delete(
      url,
      headers: {'x-access-token': authToken},
      body: jsonEncode({
        'id': id,
      }),
    );
    // fetchMatch();
  }

  Future<void> updateWinner({
    required String matchId,
    required String winnerId,
    required String winnerName,
  }) async {
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
    notifyListeners();
  }

  getMatchIndex(String matchId) {
    return _matches.indexWhere((element) => element.id == matchId);
  }

  Future<void> updateMatch({
    String currentName = 'update_match',
    required String id,
    required String type,
    String playerId = "_",
    int number = 0,
    String text = "_",
    String text2 = "_",
    bool toggle = false,
  }) async {
    final url = Uri.parse('$backendUrl/$currentName');
    http
        .post(
          url,
          headers: {'x-access-token': authToken},
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
        .then((response) {});
    notifyListeners();
  }
}
