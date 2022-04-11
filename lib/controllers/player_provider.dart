import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import '../helpers/db_helper.dart';
import '../models/player_model.dart';

class PlayerProvider extends ChangeNotifier {
  List<PlayerModel> _players = [];

  List<PlayerModel> get player {
    return [..._players];
  }

  List _selectedPlayers = [];

  List get selectedPlayers {
    return [..._selectedPlayers];
  }

  void addSelectedPlayer({
    playerName,
    playerId,
  }) {
    _selectedPlayers.addAll([playerName, playerId]);
    notifyListeners();
  }

  void removeSelectedPlayer({
    playerName,
    playerId,
  }) {
    _selectedPlayers.remove(playerName);
    _selectedPlayers.remove(playerId);
    notifyListeners();
  }
  // add state
  // for (var i in _player) {

  // }
  // bool isFreePlay = false;

  // void updateFreePlay({index,}) {
  //   isFreePlay = !isFreePlay;
  //   notifyListeners();
  // }

  void updateSelected({
    required int playerId,
    required bool isSelected,
  }) {
    bool selected = isSelected;
    selected = !selected;
    print(selected);
    int isSelectedInt = selected == false ? 0 : 1;
    updateIsSelected(playerId, isSelectedInt);
    // notifyListeners();
  }

  void updateGamePlayers({
    required int playerId,
    required String playerName,
    required bool isSelected,
  }) {
    print("isSelected: $isSelected");
    bool selected = isSelected;
    if (isSelected == true || _selectedPlayers.length < 20) {
      selected = !selected;
    }

    print(selected);
    print(_selectedPlayers.length);
    if (selected == true && _selectedPlayers.length < 20) {
      addSelectedPlayer(
        playerName: playerName,
        playerId: playerId,
      );
    } else if (selected == false && _selectedPlayers.contains(playerId)) {
      removeSelectedPlayer(
        playerName: playerName,
        playerId: playerId,
      );
    }
    print(_selectedPlayers.length);
    print(_selectedPlayers);
    int isSelectedInt = selected == false ? 0 : 1;
    updateIsSelected(playerId, isSelectedInt);
    notifyListeners();
  }

  filterListBy({
    String filter = "id",
  }) {
    List playersNames = [];
    List playersIds = [];
    for (var item in _selectedPlayers) {
      if (item is String) {
        playersNames.add(item);
      }
      if (item is int) {
        playersIds.add(item);
      }
    }
    if (filter == "id") {
      return playersIds;
    } else if (filter == "name"){
      return playersNames;
    } 
    
  }

  removeAllPlayers() {
    var _length = _selectedPlayers.length;
    _selectedPlayers.removeRange(0, _length);
  }

  void plus({
    id,
    wins,
    addAmount,
  }) {
    wins += addAmount;
    updatePlayerWins(id, wins);
  }

  Future<void> fetchPlayer() async {
    final dataList = await DBHelper.getData('player');
    _players = dataList
        .map(
          (player) => PlayerModel(
            id: player['id'] as int,
            name: player['name'] as String,
            wins: player['wins'] as int,
            dateTime: player['date_time'] as int,
            isSelected: player['is_selected'] == 0 ? false : true,
          ),
        )
        .toList();
    notifyListeners();
  }

  Future<void> fetchPlayerHttp({
    String baseName='10.0.2.2',
    String portName='5000',
    String currentName='players',
  }) async {
    final url = Uri.parse('http://$baseName:$portName/score_api/$currentName');
    final response = await http.get(url);
      print(response.body);
    final List<PlayerModel> loadCurrent = [];
    final extractedData = json.decode(response.body[0]) as Map<String,dynamic>;
    print(extractedData);
    extractedData[0].forEach((key, value) {
        loadCurrent.add(
          PlayerModel(
            id: value['_id'],
            dateTime: value['datetime'],
            isSelected: value['is_selected'],
            name: value['name'],
            wins: 0,
          ),
        );
      });
    print(loadCurrent);
    // _players = loadCurrent;
    // notifyListeners();
  }



  Future<void> addPlayerForm({
    required String name,
    required int wins,
    required int dateTime,
  }) async {
    final newPlayer = PlayerModel(
      name: name,
      wins: wins,
      dateTime: dateTime,
      isSelected: false,
    );
    _players.add(newPlayer);
    notifyListeners();
    DBHelper.insert('player', {
      'name': newPlayer.name,
      'wins': newPlayer.wins,
      'date_time': newPlayer.dateTime,
      'is_selected': newPlayer.isSelected,
    });
  }

  Future<void> updatePlayer(
    int id,
    int score,
    String player,
  ) async {
    if (player == "player1") {
      DBHelper.update('player_match', id, {
        'player1_score': score,
      });
    } else
      DBHelper.update('player_match', id, {
        'player2_score': score,
      });
  }

  Future<void> updatePlayerWins(
    int playerId,
    int win,
  ) async {
    DBHelper.update(
      'player',
      playerId,
      {
        'wins': win,
      },
    );
    fetchPlayer();
    notifyListeners();
  }

  Future<void> updateIsSelected(
    int playerId,
    int isSelected,
  ) async {
    DBHelper.update('player', playerId, {
      'is_selected': isSelected,
    });
    fetchPlayer();
    notifyListeners();
  }

  Future<void> deletePlayer(
    int playerId,
  ) async {
    DBHelper.remove(
      'player',
      playerId,
    );
    fetchPlayer();
    notifyListeners();
  }

  Future<void> updatePlayerName(
    int playerId,
    String name,
  ) async {
    DBHelper.update(
      'player',
      playerId,
      {
        'name': name,
      },
    );
    fetchPlayer();
    notifyListeners();
  }
}
