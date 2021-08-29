import 'package:flutter/material.dart';
import 'package:faker/faker.dart';
import '../helpers/db_helper.dart';
import '../models/player_model.dart';

class PlayerProvider extends ChangeNotifier {
  List<PlayerModel> _players = [];

  List<PlayerModel> get player {
    return [..._players];
  }

  // List<String> get players {
  //   return [..._players];
  // }

  // Temp function for testing
  // PlayerModel findById(int id) {
  //   return _players.firstWhere((player) => player.id == id);
  // }

  Future<void> fetchPlayer() async {
    final dataList = await DBHelper.getData('players');
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

  // Future<void> addPlayer(
  //   int id,
  //   String firstname,
  //   String lastname,
  //   int wins,
  // ) async {
  //   final newPlayer = PlayerModel(
  //     id: id,
  //     firstName: firstname,
  //     lastName: lastname,
  //     wins: wins,
  //   );
  //   _players.add(newPlayer);
  //   notifyListeners();
  //   DBHelper.insert('players', {
  //     'id': newPlayer.id,
  //     'firstname': newPlayer.firstName,
  //     'lastname': newPlayer.lastName,
  //     'wins': newPlayer.wins,
  //   });
  // }

  Future<void> addPlayer(
    int wins,
  ) async {
    final newPlayer = PlayerModel(
      firstName: faker.person.firstName(),
      lastName: faker.person.lastName(),
      wins: faker.randomGenerator.integer(20),
    );
    _players.add(newPlayer);
    notifyListeners();
    DBHelper.insert('players', {
      'firstname': newPlayer.firstName,
      'lastname': newPlayer.lastName,
      'wins': newPlayer.wins,
    });
    print(newPlayer);
  }
}
