import 'package:flutter/material.dart';
import '../helpers/db_helper.dart';
import '../models/player_model.dart';

class PlayerProvider extends ChangeNotifier {
  List<PlayerModel> _players = [];
  // String _version = '';

  List<PlayerModel> get settings {
    return [..._players];
  }

  Future<void> fetchPlayer() async {
    final dataList = await DBHelper.getData('app_settings');
    _players = dataList
        .map(
          (player) => PlayerModel(
            id: player['id'] as int?,
            firstName: player['firstname'] as String?,
            lastName: player['lastname'] as String?,
            wins: player['wins'] as int?,
          ),
        )
        .toList();
    notifyListeners();
  }

  Future<void> addPlayer(
    int id,
    String firstname,
    String lastname,
    int wins,
  ) async {
    final newPlayer = PlayerModel(
      id: id,
      firstName: firstname,
      lastName: lastname,
      wins: wins,
    );
    _players.add(newPlayer);
    notifyListeners();
    DBHelper.insert('players', {
      'id': newPlayer.id,
      'firstname': newPlayer.firstName,
      'lastname': newPlayer.lastName,
      'wins': newPlayer.wins,
    });
  }
}
