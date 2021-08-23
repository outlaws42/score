import 'package:flutter/material.dart';
import '../helpers/db_helper.dart';
import '../models/game_model.dart';

class GameProvider extends ChangeNotifier {
  List<GameModel> _games = [];
  // String _version = '';

  List<GameModel> get games {
    return [..._games];
  }

  Future<void> fetchGame() async {
    final dataList = await DBHelper.getData('games');
    _games = dataList
        .map(
          (game) => GameModel(
            id: game['id'] as int?,
            name: game['name'] as String,
            description: game['description'] as String?,
            endScore: game['endscore'] as int?,
            lowScore: game['lowscore'] as bool?,
          ),
        )
        .toList();
    notifyListeners();
  }

  Future<void> addGame({
    int? id,
    String? name,
    String? description,
    int? endscore,
    bool lowscore=false,
  }) async {
    final newGame = GameModel(
      id: id,
      name: name,
      description: description,
      endScore: endscore,
      lowScore: lowscore
    );
    _games.add(newGame);
    notifyListeners();
    DBHelper.insert('games', {
      'id': newGame.id,
      'name': newGame.name,
      'description': newGame.description,
      'endscore': newGame.endScore,
      'lowscore': newGame.lowScore,
    });
  }
}
