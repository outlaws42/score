import 'package:flutter/widgets.dart';
import 'package:faker/faker.dart';
import '../helpers/db_helper.dart';
import '../models/player_model.dart';

class PlayerProvider extends ChangeNotifier {
  

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
            name: player['name'] as String?,
            wins: player['wins'] as int?,
          ),
        )
        .toList();
        notifyListeners();
  }

  Future<void> addPlayerForm(
    // int id,
    String name,
    int wins,
  ) async {
    final newPlayer = PlayerModel(
      // id: id,
      name: name,
      wins: wins,
    );
    _players.add(newPlayer);
    notifyListeners();
    DBHelper.insert('players', {
      // 'id': newPlayer.id,
      'name': newPlayer.name,
      'wins': newPlayer.wins,
    });
  }

  Future<void> addPlayer(
  ) async {
    final newPlayer = PlayerModel(
      name: faker.person.firstName(),
      wins: faker.randomGenerator.integer(20),
    );
    _players.add(newPlayer);
    notifyListeners();
    DBHelper.insert('players', {
      'name': newPlayer.name,
      'wins': newPlayer.wins,
    });
    print(newPlayer);
  }

  Future<void> updatePlayer(
    int id,
    int score,
    String player,
  ) async {
    // final newPlayer = MatchModel(
    //   firstName: faker.person.firstName(),
    //   lastName: faker.person.lastName(),
    //   wins: faker.randomGenerator.integer(20),
    // );
    // _matches.add(newPlayer);
    // notifyListeners();
    if (player == "player1") {
      DBHelper.update('indv_matches',id , {
      'player1_score': score,
    });
    } else DBHelper.update('indv_matches',id , {
      'player2_score': score,
    });
    
  }
}
