import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../models/game_model.dart';

class GameProvider extends ChangeNotifier {
  List<GameModel> _games = [];

  List<GameModel> get games {
    return [..._games];
  }

  final String authToken;

  GameProvider(this.authToken);

  bool isLowScore = false;

  void updateLowScore() {
    isLowScore = !isLowScore;
    notifyListeners();
  }

  void updateSelected({required String gameId, required bool isSelected}) {
    bool selected = isSelected;
    selected = !selected;
    int isSelectedInt = selected == false ? 0 : 1;
    updateIsSelected(gameId, isSelectedInt);
  }

  Future<void> fetchGame({
    String baseName = 'www.eldrway.com',
    String portName = '3000',
    String currentName = 'games',
  }) async {
    final url = Uri.parse('https://$baseName/score_api/$currentName');
    final response = await http.get(
      url,
      headers: {
        'x-access-token': authToken
      },
    );
    final List<GameModel> loadCurrent = [];
    final json = jsonDecode(response.body);
    if (json != null) {
      json.forEach((value) {
        loadCurrent.add(GameModel.fromJson(value));
      });
    }
    _games = loadCurrent;
    notifyListeners();
  }

  Future<void> addGame({
    String baseName = 'www.eldrway.com',
    String portName = '3000',
    String currentName = 'add_game',
    required String name,
    required String description,
    bool lowScore = false,
  }) async {
    final url = Uri.parse('https://$baseName/score_api/$currentName');
    http
        .post(
      url,
      headers: {
        'x-access-token': authToken
      },
      body: jsonEncode({
        'name': name,
        'description': description,
        'low_score': lowScore,

        // 'players': players
      }),
    )
        .then((response) {
      print('This is the response: ${jsonDecode(response.body)}');
      final newGame = GameModel(
        id: jsonDecode(response.body)['_id'],
        name: jsonDecode(response.body)['name'],
        description: jsonDecode(response.body)['description'],
        lowScore: jsonDecode(response.body)['low_score'],
        dateTime: jsonDecode(response.body)['datetime'],
        isSelected: jsonDecode(response.body)['is_selected'],
      );
      _games.add(newGame);
      notifyListeners();
    });
  }

  Future<void> updateIsSelected(
    String gameId,
    int isSelected,
  ) async {
    // DBHelper.update('game', gameId, {
    //   'is_selected': isSelected,
    // });
    fetchGame();
    notifyListeners();
  }

  Future<void> deleteGame(
    String id,
  ) async {
    // DBHelper.remove('game',id,
    // );
    fetchGame();
    notifyListeners();
  }

  Future<void> updateGame({
    required String gameId,
    required String name,
    required String description,
    required int lowScore,
  }) async {
    // DBHelper.update('game', gameId, {
    //   'name': name,
    //   'description': description,
    //   'end_score': endScore,
    //   'low_score': lowScore,
    //   'free_play': freePlay,
    //   'is_selected': 0,
    // });
    fetchGame();
    notifyListeners();
  }
}
