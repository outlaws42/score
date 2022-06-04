import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:score/helpers.dart';
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

  final String authToken;

  PlayerProvider(this.authToken);

  void addSelectedPlayer({
    playerName,
    playerId,
  }) {
    Color _randomColor = FunctionHelper.randomColor();
    int intColor = FunctionHelper.convertColorInt(color: _randomColor);

    _selectedPlayers.addAll([
      {
        "player_name": playerName,
        "player_id": playerId,
        "score": 0,
        "color": intColor,
      }
    ]);
    notifyListeners();
  }

  void removeSelectedPlayer({
    playerName,
    playerId,
  }) {
    _selectedPlayers.removeWhere((element) => element['player_id'] == playerId);
    notifyListeners();
  }

  void updateSelected({
    required String playerId,
    required bool isSelected,
  }) {
    bool selected = isSelected;
    selected = !selected;
    updateIsSelected(playerId, selected);
  }

  void updateGamePlayers({
    required String playerId,
    required String playerName,
    required bool isSelected,
  }) {
    bool selected = isSelected;
    if (isSelected == true || _selectedPlayers.length < 20) {
      selected = !selected;
      print("Selected: $selected");
    }

    if (selected == true && _selectedPlayers.length < 20) {
      addSelectedPlayer(
        playerName: playerName,
        playerId: playerId,
      );
    } else if (selected == false) {
      removeSelectedPlayer(
        playerName: playerName,
        playerId: playerId,
      );
    }
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

  Future<void> fetchPlayer({
    String baseName = '192.168.1.9:3000', //10.0.2.2
    String portName = '3000',
    String currentName = 'players',
  }) async {
    final url = Uri.parse('http://$baseName/score_api/$currentName');
    final response = await http.get(
      url,
      headers: {
        'x-access-token': authToken
      },
    );
    final List<PlayerModel> loadCurrent = [];
    final json = jsonDecode(response.body);

    if (json != null) {
      json.forEach((value) {
        loadCurrent.add(PlayerModel.fromJson(value));
      });
    }
    _players = loadCurrent;
    notifyListeners();
  }

  Future<void> addPlayerForm({
    String baseName = '192.168.1.9:3000',
    String portName = '3000',
    String currentName = 'add_player',
    required String name,
  }) async {
    final url = Uri.parse('http://$baseName/score_api/$currentName');
    http
        .post(
      url,
      headers: {
        'x-access-token': authToken
      },
      body: jsonEncode({
        'name': name,
      }),
    )
        .then((response) {
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

  Future<void> updatePlayerWins(
    String playerId,
    int win,
  ) async {
    int playerIndex = _players.indexWhere((element) => element.id == playerId);
    _players[playerIndex].wins = win;
    updatePlayer(id: playerId, number: win, type: 'wins');
    notifyListeners();
  }

  Future<void> updateIsSelected(
    String playerId,
    bool isSelected,
  ) async {
    final playerIsSelected =
        _players.firstWhere((element) => element.id == playerId);
    playerIsSelected.isSelected = isSelected;
  }

  Future<void> deletePlayer(
    String playerId,
  ) async {
    fetchPlayer();
    notifyListeners();
  }

  Future<void> updatePlayerName(
    String playerId,
    String name,
  ) async {
    fetchPlayer();
    notifyListeners();
  }

  Future<void> updatePlayer({
    String baseName = '192.168.1.9:3000',
    String portName = '3000',
    String currentName = 'update_player',
    required String id,
    required String type,
    String playerId = "_",
    int number = 0,
    String text = "_",
    String text2 = "_",
    bool toggle = false,
  }) async {
    final url = Uri.parse('http://$baseName/score_api/$currentName');
    http
        .post(
      url,
      headers: {
        'x-access-token': authToken
      },
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
