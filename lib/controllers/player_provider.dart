import 'package:flutter/widgets.dart';
import 'package:faker/faker.dart';
import '../helpers/db_helper.dart';
import '../models/player_model.dart';

class PlayerProvider extends ChangeNotifier {
  

  List<PlayerModel> _players = [];

  List<PlayerModel> get player {
    return [..._players];
  }


// bool isSelected = false;

  void updateSelected({
    required int playerId,
    required bool isSelected
  }) {
    bool selected = isSelected;
    selected = !selected;
    int isSelectedInt = selected == false ? 0 : 1;
    updateIsSelected(playerId, isSelectedInt);
    // notifyListeners();
  }

  void plus({
    id,
    wins,
    addAmount,
  }) {
    wins += addAmount;
    print(wins);
    updatePlayerWins(id, wins);
    // fetchMatch();
    // notifyListeners();
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

  Future<void> addPlayerForm({
    // int id,
    required String name,
    required int wins,
    required int dateTime,
  }) async {
    final newPlayer = PlayerModel(
      // id: id,
      name: name,
      wins: wins,
      dateTime: dateTime,
      isSelected: false
    );
    _players.add(newPlayer);
    notifyListeners();
    DBHelper.insert('player', {
      // 'id': newPlayer.id,
      'name': newPlayer.name,
      'wins': newPlayer.wins,
      'date_time': newPlayer.dateTime,
      'is_selected': newPlayer.isSelected,

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
    DBHelper.insert('player', {
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
      DBHelper.update('player_match',id , {
      'player1_score': score,
    });
    } else DBHelper.update('player_match',id , {
      'player2_score': score,
    });
    
  }

  Future<void> updatePlayerWins(
    int playerId,
    int win,
  ) async {
    DBHelper.update('player',playerId , {
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
    print('Update is selected $isSelected');
    DBHelper.update('player', playerId, {
      'is_selected': isSelected,
    });
    fetchPlayer();
    notifyListeners();
  }
  Future<void> deletePlayer(
    int playerId,
  ) async {
    DBHelper.remove('player',playerId,
    );
    fetchPlayer();
    notifyListeners();
  }

  Future<void> updatePlayerName(
    int playerId,
    String name,
  ) async {
    DBHelper.update('player',playerId , {
      'name': name,
    },
    );
    fetchPlayer();
    notifyListeners();
  }
}
