import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../helpers/db_helper.dart';
import '../models/game_model.dart';

class GameProvider extends ChangeNotifier {
  List<GameModel> _games = [];

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

  void updateSelected({
    required String gameId,
    required bool isSelected
  }) {
    bool selected = isSelected;
    selected = !selected;
    int isSelectedInt = selected == false ? 0 : 1;
    updateIsSelected(gameId, isSelectedInt);
  }

  // Future<void> fetchGame() async {
  //   final dataList = await DBHelper.getData('game');
  //   _games = dataList
  //       .map(
  //         (game) => GameModel(
  //           id: game['id'] as String,
  //           name: game['name'] as String,
  //           description: game['description'] as String,
  //           endScore: game['end_score'] as int?,
  //           lowScore: game['low_score'] == 0 ? false : true,
  //           freePlay: game['free_play'] == 0 ? false : true,
  //           isSelected: game['is_selected'] == 0 ? false : true,
  //           dateTime: game['date_time'] as int,
  //         ),
  //       )
  //       .toList();
  //   notifyListeners();
  // }

  Future<void> fetchGame({
    String baseName='10.0.2.2',
    String portName='5000',
    String currentName='games',
  }) async {
    final url = Uri.parse('http://$baseName:$portName/score_api/$currentName');
    final response = await http.get(url);
      print(response.body);
    final List<GameModel> loadCurrent = [];
    final json = jsonDecode(response.body);
    // final test = PlayerModel.fromJson(json);
    if (json != null) {
    json.forEach((value){
      loadCurrent.add(
        GameModel.fromJson(value)
        );

    });
    }
    print(loadCurrent);
    _games = loadCurrent;
    notifyListeners();
  }

  Future<void> addGameForm({
    String name="game",
    String description = 'This game will challenge you',
    int? endScore,
    bool lowScore=false,
    bool freePlay = false,
    bool isSelected = false,
    int dateTime = 0,
  }) async {
    final newGame = GameModel(
      name: name,
      description: description,
      endScore: endScore,
      lowScore: lowScore,
      freePlay: freePlay,
      isSelected: isSelected,
      dateTime: dateTime,
    );
    _games.add(newGame);
    notifyListeners();
    DBHelper.insert('game', {
      'name': newGame.name,
      'description': newGame.description,
      'end_score': newGame.endScore,
      'low_score': newGame.lowScore== false ? 0 : 1,
      'free_play': newGame.freePlay== false ? 0 : 1,
      'is_selected': newGame.isSelected,
      'date_time': newGame.dateTime,
    });
  }


  Future<void> addGame({
    String name="game",
    String description = 'This game will challenge you',
    int? endScore,
    bool lowScore=false,
    bool freePlay = false,
    bool isSelected = false,
    int dateTime = 0,
  }) async {
    final url = Uri.parse('http://10.0.2.2:5000/score_api/add_game'); 
    final newGame = GameModel(
      name: name,
      description: description,
      endScore: endScore,
      lowScore: lowScore,
      freePlay: freePlay,
      isSelected: isSelected,
      dateTime: dateTime,
    );
    _games.add(newGame);
    notifyListeners();
    DBHelper.insert('game', {
      'name': newGame.name,
      'description': newGame.description,
      'end_score': newGame.endScore,
      'low_score': newGame.lowScore== false ? 0 : 1,
      'free_play': newGame.freePlay== false ? 0 : 1,
      'is_selected': newGame.isSelected,
      'date_time': newGame.dateTime,
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
   required int? endScore,
   required int lowScore,
   required int freePlay,
  }
  ) async { 
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
