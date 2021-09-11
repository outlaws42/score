import 'package:flutter/material.dart';
import 'package:faker/faker.dart';
import '../helpers/db_helper.dart';
import '../models/match_model.dart';

class MatchProvider extends ChangeNotifier {
  List<MatchModel> _matches = [];

  List<MatchModel> get match {
    return [..._matches];
  }

  Future<void> fetchPlayer() async {
    final dataList = await DBHelper.getData('indv_match');
    _matches = dataList
        .map(
          (match) => MatchModel(
            id: match['id'] as int?,
            matchName: match['matchname'] as String?,
            playerId1: match['player1_id'] as int?,
            playerId2: match['player2_id'] as int?,
            playerId3: match['player3_id'] as int?,
            playerId4: match['player4_id'] as int?,
            playerId5: match['player5_id'] as int?,
            playerScore1: match['playerscore1'] as int?,
            playerScore2: match['playerscore2'] as int?,
            playerScore3: match['playerscore3'] as int?,
            playerScore4: match['playerscore4'] as int?,
            playerScore5: match['playerscore5'] as int?,
            gameId: match['game_id'] as int?,
            winScore: match['winscore'] as int?,
            lowScore: match['lowscore'] == 0 ? false : true,
            isComplete: match['iscomplete'] == 0 ? false : true,
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

  // Future<void> addPlayer(
  //   int wins,
  // ) async {
  //   final newPlayer = PlayerModel(
  //     firstName: faker.person.firstName(),
  //     lastName: faker.person.lastName(),
  //     wins: faker.randomGenerator.integer(20),
  //   );
  //   _players.add(newPlayer);
  //   notifyListeners();
  //   DBHelper.insert('players', {
  //     'firstname': newPlayer.firstName,
  //     'lastname': newPlayer.lastName,
  //     'wins': newPlayer.wins,
  //   });
  //   print(newPlayer);
  // }
}
