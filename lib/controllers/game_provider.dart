import 'package:flutter/material.dart';
import 'package:faker/faker.dart';
import '../helpers/db_helper.dart';
import '../models/game_model.dart';

class GameProvider extends ChangeNotifier {
  List<GameModel> _games = [];
  // String _version = '';

  List<GameModel> get games {
    return [..._games];
  }

  bool isLowScore = false;

  void updateLowScore() {
    isLowScore = !isLowScore;
    notifyListeners();
  }

  bool isFreePlay = false;

  void updateFreePlay() {
    isFreePlay = !isFreePlay;
    notifyListeners();
  }

  Future<void> fetchGame() async {
    final dataList = await DBHelper.getData('games');
    _games = dataList
        .map(
          (game) => GameModel(
            id: game['id'] as int?,
            name: game['name'] as String,
            description: game['description'] as String?,
            endScore: game['end_score'] as int?,
            lowScore: game['low_score'] == 0 ? false : true,
            freePlay: game['free_play'] == 0 ? false : true,
          ),
        )
        .toList();
    notifyListeners();
  }

  Future<void> addGameForm({
    // int? id,
    String? name,
    String? description,
    int? endScore,
    bool lowScore=false,
    bool freePlay = false,
  }) async {
    final newGame = GameModel(
      // id: id,
      name: name,
      description: description,
      endScore: endScore,
      lowScore: lowScore,
      freePlay: freePlay,
    );
    _games.add(newGame);
    notifyListeners();
    DBHelper.insert('games', {
      // 'id': newGame.id,
      'name': newGame.name,
      'description': newGame.description,
      'end_score': newGame.endScore,
      'low_score': newGame.lowScore== false ? 0 : 1,
      'free_play': newGame.freePlay== false ? 0 : 1,
    });
  }

  Future<void> addGame({
    // int? id,
    String? name,
    String? description,
    int? endscore,
    bool lowscore=false,
  }) async {
    final newGame = GameModel(
      // id: id,
      name: faker.sport.name(),
      description: faker.lorem.sentence(),
      endScore: faker.randomGenerator.integer(21),
      lowScore: lowscore,
      freePlay: false,
    );
    _games.add(newGame);
    notifyListeners();
    DBHelper.insert('games', {
      // 'id': newGame.id,
      'name': newGame.name,
      'description': newGame.description,
      'end_score': newGame.endScore,
      'low_score': newGame.lowScore== false ? 0 : 1,
      'free_play': newGame.freePlay== false ? 0 : 1,  
    });
  }
}
