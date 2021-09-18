import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:faker/faker.dart';
import '../helpers/db_helper.dart';
import '../models/player_model.dart';

class PlayerProv extends StateNotifier<List<PlayerModel>> {
  PlayerProv() :super([]);

  List<PlayerModel> _players = [];

  List<PlayerModel> get player {
    return [..._players];
  }


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
        // notifyListeners();
  }

  Future<void> addPlayerForm(
    // int id,
    String firstname,
    String lastname,
    int wins,
  ) async {
    final newPlayer = PlayerModel(
      // id: id,
      firstName: firstname,
      lastName: lastname,
      wins: wins,
    );
    _players.add(newPlayer);
    // notifyListeners();
    DBHelper.insert('players', {
      // 'id': newPlayer.id,
      'firstname': newPlayer.firstName,
      'lastname': newPlayer.lastName,
      'wins': newPlayer.wins,
    });
  }

  Future<void> addPlayer(
  ) async {
    final newPlayer = PlayerModel(
      firstName: faker.person.firstName(),
      lastName: faker.person.lastName(),
      wins: faker.randomGenerator.integer(20),
    );
    _players.add(newPlayer);
    // notifyListeners();
    DBHelper.insert('players', {
      'firstname': newPlayer.firstName,
      'lastname': newPlayer.lastName,
      'wins': newPlayer.wins,
    });
    print(newPlayer);
  }
}
