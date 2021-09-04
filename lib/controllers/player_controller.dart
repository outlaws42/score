import 'package:get/get.dart';
import 'package:faker/faker.dart';
import '../helpers/db_helper.dart';
import '../models/player_model.dart';

class PlayerController extends GetxController {
  List<PlayerModel> players = <PlayerModel>[].obs;

  // RxList<PlayerModel> get player {
  //   return [..._players].obs;
  // }

  // @override
  // void onInit() {
  //   super.onInit();
  //   fetchPlayer();
  // }

  Future<void> fetchPlayer() async {
    final dataList = await DBHelper.getData('players');
    players = dataList
        .map(
          (player) => PlayerModel(
            id: player['id'] as int?,
            firstName: player['firstname'] as String?,
            lastName: player['lastname'] as String?,
            wins: player['wins'] as int?,
          ),
        )
        .toList();
    // update();
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
  ) async {
    final newPlayer = PlayerModel(
      firstName: faker.person.firstName(),
      lastName: faker.person.lastName(),
      wins: faker.randomGenerator.integer(20),
    );
    players.add(newPlayer);
    // _players.refresh();
    // fetchPlayer();
    // update();
    DBHelper.insert('players', {
      'firstname': newPlayer.firstName,
      'lastname': newPlayer.lastName,
      'wins': newPlayer.wins,
    });
    print(newPlayer);
  }
}
