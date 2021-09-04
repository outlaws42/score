import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:faker/faker.dart';
import '../helpers/db_helper.dart';
import '../models/game_model.dart';

class GameController extends GetxController {
  List<GameModel> games = <GameModel>[].obs;
  // String _version = '';

  // List<GameModel> get games {
  //   return [..._games];
  // }

  //  @override
  // void onInit() {
  //   super.onInit();
  //   fetchGame();
  // }

  Future<void> fetchGame() async {
    final dataList = await DBHelper.getData('games');
    games = dataList
        .map(
          (game) => GameModel(
            id: game['id'] as int?,
            name: game['name'] as String,
            description: game['description'] as String?,
            endScore: game['endscore'] as int?,
            lowScore: game['lowscore'] == 0 ? false : true,
          ),
        )
        .toList();
    // notifyListeners();
  }

  // Future<void> addGame({
  //   int? id,
  //   String? name,
  //   String? description,
  //   int? endscore,
  //   bool lowscore=false,
  // }) async {
  //   final newGame = GameModel(
  //     id: id,
  //     name: name,
  //     description: description,
  //     endScore: endscore,
  //     lowScore: lowscore
  //   );
  //   _games.add(newGame);
  //   notifyListeners();
  //   DBHelper.insert('games', {
  //     'id': newGame.id,
  //     'name': newGame.name,
  //     'description': newGame.description,
  //     'endscore': newGame.endScore,
  //     'lowscore': newGame.lowScore,
  //   });
  // }

  Future<void> addGame({
    int? id,
    String? name,
    String? description,
    int? endscore,
    bool lowscore=false,
  }) async {
    final newGame = GameModel(
      id: id,
      name: faker.sport.name(),
      description: faker.lorem.sentence(),
      endScore: faker.randomGenerator.integer(21),
      lowScore: lowscore
    );
    games.add(newGame);
    // notifyListeners();
    DBHelper.insert('games', {
      'id': newGame.id,
      'name': newGame.name,
      'description': newGame.description,
      'endscore': newGame.endScore,
      'lowscore': newGame.lowScore== false ? 0 : 1, 
    });
  }
}
