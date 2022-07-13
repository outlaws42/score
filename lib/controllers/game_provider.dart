import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../models/game_model.dart';
import '../helpers.dart';

class GameProvider extends ChangeNotifier {
  List<GameModel> _games = [];

  List<GameModel> get games {
    return [..._games];
  }

  final String authToken;

  GameProvider(
    this.authToken,
  );

  bool isLowScore = false;

  void updateLowScore(
    // required bool isLowScore,
  ) {
    print('isLowScore before: $isLowScore');
    isLowScore = !isLowScore;
    print('isLowScore After: $isLowScore');
    notifyListeners();
  }

  void toggleLowScore({
    required String id,
    required bool isLowScore,
  }) {
    int _gameIndex = getGameIndex(id); 
    print('isLowScore before: $isLowScore');
    isLowScore = !isLowScore;
    print('isLowScore After: $isLowScore');
    _games[_gameIndex].lowScore =isLowScore;
    notifyListeners();
  }

  void toggleSelected({
    required String id,
    required bool isSelected,
  }) {
    isSelected = !isSelected;
    updateSelected(
      id: id,
      isSelected: isSelected,
    );
  }

  Future<void> fetchGame({
    String currentName = 'games',
  }) async {
    final url = Uri.parse('$backendUrl/$currentName');
    final response = await http.get(
      url,
      headers: {'x-access-token': authToken},
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
    String currentName = 'add_game',
    required String name,
    required String description,
    String desUrl = '',
    bool lowScore = false,
  }) async {
    final url = Uri.parse('$backendUrl/$currentName');
    http
        .post(
      url,
      headers: {'x-access-token': authToken},
      body: jsonEncode({
        'name': name,
        'description': description,
        'des_url': desUrl,
        'low_score': lowScore,

        // 'players': players
      }),
    )
        .then((response) {
      final newGame = GameModel(
        id: jsonDecode(response.body)['_id'],
        name: jsonDecode(response.body)['name'],
        description: jsonDecode(response.body)['description'],
        desUrl: jsonDecode(response.body)['des_url'],
        lowScore: jsonDecode(response.body)['low_score'],
        dateTime: jsonDecode(response.body)['datetime'],
        isSelected: jsonDecode(response.body)['is_selected'],
      );
      _games.add(newGame);
      notifyListeners();
    });
  }

  Future<void> updateSelected({
    String currentName = 'update_selected',
    required String id,
    required bool isSelected,
  }) async {
    // Update State
    int gameIndex = getGameIndex(id);
    _games[gameIndex].isSelected = isSelected;
    notifyListeners();
    //Update Database
    final url = Uri.parse('$backendUrl/$currentName');
    http
        .post(
          url,
          headers: {'x-access-token': authToken},
          body: jsonEncode({
            '_id': id,
            'is_selected': isSelected,
          }),
        )
        .then((response) {});
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
    String currentName = 'update_game',
    required String id,
    required String name,
    required String description,
    required String desUrl,
    required bool lowScore,
  }) async {
    final url = Uri.parse('$backendUrl/$currentName');
    // Update State
    int _gameIndex = getGameIndex(id);
    _games[_gameIndex].name = name;
    _games[_gameIndex].description = description;
    _games[_gameIndex].desUrl = desUrl;
    _games[_gameIndex].lowScore = lowScore;
    notifyListeners();
    //Update Database
    http
        .post(
          url,
          headers: {'x-access-token': authToken},
          body: jsonEncode({
            '_id': id,
            'name': name,
            'description': description,
            'des_url': desUrl,
            'low_score': lowScore,
          }),
        )
        .then((response) {});
  }

  getGameIndex(String gameId) {
    return _games.indexWhere((element) => element.id == gameId);
  }
}
