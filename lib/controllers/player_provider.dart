import 'dart:convert';
import 'dart:math';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:score/models/match_model.dart';
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

    final _random = Random();
    final randomColor = Color.fromARGB(
      _random.nextInt(256),
      _random.nextInt(256),
      _random.nextInt(256),
      _random.nextInt(256),
    );
    String colorString = randomColor.toString();
    String valueString = colorString.split('(0x')[1].split(')')[0];
    int value = int.parse(valueString, radix: 16);

    // final color =int.parse(randomColor, radix: 16);
    print(value);

    _selectedPlayers.addAll([
      {
        "player_name": playerName,
        "player_id": playerId,
        "score": 0,
        "color": value,
      }
    ]
    
        // Player(
        //   playerId: playerId,
        //   playerName: playerName,
        //   score: 0,
        //   color: 0,
        // )

        // "player_name": playerName,
        // "player_id":playerId,
        // "score": 0,
        // "color": 0,

        );
    print('This is _selectedPlayers: $_selectedPlayers');
    notifyListeners();
  }

  void removeSelectedPlayer({
    playerName,
    playerId,
  }) {
    _selectedPlayers.removeWhere((element) => element['player_id'] == playerId);
    // _selectedPlayers.remove(playerId);
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
    required String playerId,
    required bool isSelected,
  }) {
    bool selected = isSelected;
    selected = !selected;
    // print(selected);
    // int isSelectedInt = selected == false ? 0 : 1;
    updateIsSelected(playerId, selected);
    // notifyListeners();
  }

  void updateGamePlayers({
    required String playerId,
    required String playerName,
    required bool isSelected,
  }) {
    // print("isSelected: $isSelected");
    bool selected = isSelected;
    if (isSelected == true || _selectedPlayers.length < 20) {
      selected = !selected;
      print("Selected: $selected");
    }

    // print(selected);
    // print(_selectedPlayers.length);
    if (selected == true && _selectedPlayers.length < 20) {
      addSelectedPlayer(
        playerName: playerName,
        playerId: playerId,
      );
      // && _selectedPlayers.contains(playerId)
    } else if (selected == false) {
      removeSelectedPlayer(
        playerName: playerName,
        playerId: playerId,
      );
    }
    // print(_selectedPlayers.length);
    // print(_selectedPlayers);
    // int isSelectedInt = selected == false ? 0 : 1;
    updateIsSelected(playerId, selected);
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
    } else if (filter == "name") {
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

  // Future<void> fetchPlayer() async {
  //   final dataList = await DBHelper.getData('player');
  //   _players = dataList
  //       .map(
  //         (player) => PlayerModel(
  //           id: player['id'] as String,
  //           name: player['name'] as String,
  //           wins: player['wins'] as int,
  //           dateTime: player['date_time'] as int,
  //           isSelected: player['is_selected'] == 0 ? false : true,
  //         ),
  //       )
  //       .toList();
  //   notifyListeners();
  // }

  Future<void> fetchPlayer({
    String baseName = '192.168.1.9', //10.0.2.2
    String portName = '3000',
    String currentName = 'players',
  }) async {
    final url = Uri.parse('http://$baseName:$portName/score_api/$currentName');
    final response = await http.get(url);
    // print(response.body);
    final List<PlayerModel> loadCurrent = [];
    final json = jsonDecode(response.body);
    // final test = PlayerModel.fromJson(json);
    if (json != null) {
      json.forEach((value) {
        loadCurrent.add(PlayerModel.fromJson(value));
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
    _players = loadCurrent;
    notifyListeners();
  }

  Future<void> addPlayerForm({
    String baseName = '192.168.1.9',
    String portName = '3000',
    String currentName = 'add_player',
    required String name,
    // required List players
  }) async {
    final url = Uri.parse('http://$baseName:$portName/score_api/$currentName');
    http
        .post(
      url,
      body: jsonEncode({
        'name': name,
        // 'players': players
      }),
    )
        .then((response) {
      // print('This is the response: ${jsonDecode(response.body)}');
      final newPlayer = PlayerModel(
        id: jsonDecode(response.body)['_id'],
        name: jsonDecode(response.body)['name'],
        wins: jsonDecode(response.body)['wins'],
        dateTime: jsonDecode(response.body)['datetime'],
        isSelected: jsonDecode(response.body)['is_selected'],
      );
      _players.add(newPlayer);
      notifyListeners();
    });
  }

  // Future<void> addPlayerForm({
  //   required String name,
  //   required int wins,
  //   required int dateTime,
  // }) async {
  //   final newPlayer = PlayerModel(
  //     name: name,
  //     wins: wins,
  //     dateTime: dateTime,
  //     isSelected: false,
  //   );
  //   _players.add(newPlayer);
  //   notifyListeners();
  //   // DBHelper.insert('player', {
  //   //   'name': newPlayer.name,
  //   //   'wins': newPlayer.wins,
  //   //   'date_time': newPlayer.dateTime,
  //   //   'is_selected': newPlayer.isSelected,
  //   // });
  // }

  Future<void> updatePlayer(
    String id,
    int score,
    String player,
  ) async {
    // if (player == "player1") {
    //   DBHelper.update('player_match', id, {
    //     'player1_score': score,
    //   });
    // } else
    //   DBHelper.update('player_match', id, {
    //     'player2_score': score,
    //   });
  }

  Future<void> updatePlayerWins(
    String playerId,
    int win,
  ) async {
    // DBHelper.update(
    //   'player',
    //   playerId,
    //   {
    //     'wins': win,
    //   },
    // );
    int matchIndex = _players.indexWhere((element) => element.id == playerId);
    _players[matchIndex].wins = win;
    notifyListeners();
  }

  Future<void> updateIsSelected(
    String playerId,
    bool isSelected,
  ) async {
    final playerIsSelected =
        _players.firstWhere((element) => element.id == playerId);
    playerIsSelected.isSelected = isSelected;

    // DBHelper.update('player', playerId, {
    //   'is_selected': isSelected,
    // });
    // fetchPlayer();
    // notifyListeners();
  }

  Future<void> deletePlayer(
    String playerId,
  ) async {
    // DBHelper.remove(
    //   'player',
    //   playerId,
    // );
    fetchPlayer();
    notifyListeners();
  }

  Future<void> updatePlayerName(
    String playerId,
    String name,
  ) async {
    // DBHelper.update(
    //   'player',
    //   playerId,
    //   {
    //     'name': name,
    //   },
    // );
    fetchPlayer();
    notifyListeners();
  }
}
