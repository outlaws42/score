import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:get/get.dart';
// import 'package:score/controllers/match_provider.dart';
// import 'package:score/models/match_model.dart';
// import 'package:score/views/match.dart';
import '../controllers/providers.dart';
import '../helpers.dart';

class MatchForm extends StatefulWidget {
  @override
  State<MatchForm> createState() => _MatchFormState();
}

class _MatchFormState extends State<MatchForm> {
  // final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  // final _player = (playerProvider);

  String _game = 'Select Game';
  // String _player1 = 'Select Player1';
  // String _player2 = 'Select Player2';
  // String _id1 = "";
  // String _id2 = "";
  // int _endScore = 0;
  String _gameid = "";
  bool _lowScore = false;
  // bool _freePlay = false;
  String? selected;
  List _gamePlayers = [];
  // List _gamePlayersId = [];

  void goToGame() async {
    var dataFromGame = await Get.toNamed(
      "/games",
      arguments: ['form', ''],
    );
    _game = dataFromGame[0];
    // _endScore = dataFromGame[1];
    _gameid = dataFromGame[1];
    _lowScore = dataFromGame[2];
    // _freePlay = dataFromGame[4];
    // print('$_game, $_gameid, $_lowScore');
    setState(() {});
  }

  void goToPlay() async {
    var dataFromPlayer = await Get.toNamed(
      "/players_select",
      arguments: ['form', ''],
    );
    // print('dataFromPlayer: $dataFromPlayer');
    for (var item in dataFromPlayer) {
      _gamePlayers.add(item);
    }
    // if (player == "player1") {
    //   _player1 = dataFromPlayer[0];
    //   _id1 = dataFromPlayer[1];
    // } else if (player == "player2") {
    //   _player2 = dataFromPlayer[0];
    //   _id2 = dataFromPlayer[1];
    // }
    // _gamePlayers = dataFromPlayer;
    setState(() {});
  }

  Future<void> save({
    required String gameName,
    required String gameId,
    required List<dynamic> players, // List<Map<String, dynamic>>
    bool lowScore = false,
  }) async {
    await context
        .read(matchProvider)
        .addMatchHttp(
          gameName: gameName,
          players: players,
        );
            int _date = context.read(matchProvider).match.length > 0
                ? context.read(matchProvider).match.last.dateTime
                : 1;
            var _index = context
                .read(matchProvider)
                .match
                .indexWhere((match) => match.dateTime == _date);
            print(
                'This is match from match form: ${context.read(matchProvider).match[_index].id}');

            String _id = context.read(matchProvider).match[_index].id;
            Get.offAllNamed("/match_current", arguments: [_id, "match_form"]);
  }

  void _warnDialog() {
    Get.defaultDialog(
      radius: 10.0,
      title: "Warning",
      content: Column(
        children: [
          Text("You need to select a game and  at least 2 players"),
          TextButton(
            onPressed: () => Get.back(),
            child: Text("Ok"),
            style: ElevatedButton.styleFrom(
              primary: Theme.of(context).appBarTheme.backgroundColor,
              onPrimary: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Match",
          style: Theme.of(context).textTheme.headline3,
        ),
        actions: [
          PageWidgets().iconButtonBarDocs(
            context: context,
            data: "assets/help_match_form.md",
            icon: Icon(MdiIcons.help),
            iconSize: 20,
          ),
        ],
      ),
      body: Consumer(builder: (context, ScopedReader watch, child) {
        return SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'Match Information',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
                // // Game Name
                // FormWidgets.formTextInput(
                //   context: context,
                //   controller: _nameController,
                //   labelText: "Match Name (Optional)",
                //   hintText: "The name of match",
                //   maxLength: 20,
                // ),

                // Game Selection
                Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Card(
                    elevation: 4,
                    child: ListTile(
                      title: Text('$_game',
                          style: Theme.of(context).textTheme.headline4),
                      trailing: Icon(
                        Icons.games,
                        color: Theme.of(context).appBarTheme.backgroundColor,
                      ),
                      onTap: () => goToGame(),
                    ),
                  ),
                ),

                // player1 Selection
                _gamePlayers.length == 0
                    ? Container(
                        margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Card(
                          elevation: 4,
                          child: ListTile(
                              title: Text('Select Players',
                                  style: Theme.of(context).textTheme.headline4),
                              trailing: Icon(
                                Icons.person_add,
                                color: Theme.of(context)
                                    .appBarTheme
                                    .backgroundColor,
                              ),
                              onTap: () {
                                // var _player =
                                //     context.read(playerProvider).player;
                                // print(_player.length);
                                // for (var index = 0;
                                //     index < _player.length;
                                //     index++) {
                                //   if (_player[index].isSelected == true) {
                                //     context.read(playerProvider).updateSelected(
                                //         playerId: _player[index].id,
                                //         isSelected: true,
                                //       );
                                //   }
                                // }
                                // _gamePlayers = [];
                                // _gamePlayersId = [];
                                goToPlay();
                              }),
                        ),
                      )
                    : Column(
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: Card(
                              elevation: 4,
                              child: ListTile(
                                title: Text('Selected Players',
                                    style:
                                        Theme.of(context).textTheme.headline4),
                                trailing: Icon(
                                  Icons.person_add,
                                  color: Theme.of(context)
                                      .appBarTheme
                                      .backgroundColor,
                                ),
                                onTap: () {
                                  _gamePlayers = [];
                                  // _gamePlayersId = [];
                                  goToPlay();
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 250,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: _gamePlayers.length,
                              itemBuilder: (ctx, index) {
                                return ListTile(
                                  title:
                                      Text(_gamePlayers[index]['player_name']),
                                );
                              },
                              physics: const BouncingScrollPhysics(
                                parent: AlwaysScrollableScrollPhysics(),
                              ),
                            ),
                          ),
                        ],
                      ),

                // player2 Selection
                // Container(
                //   margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                //   child: Card(
                //     elevation: 4,
                //     child: ListTile(
                //       title: Text('$_player2',
                //           style: Theme.of(context).textTheme.headline4),
                //       trailing: Icon(
                //         Icons.person_add,
                //         color: Theme.of(context).appBarTheme.backgroundColor,
                //       ),
                //       onTap: () => goToPlay('player2', _id1),
                //     ),
                //   ),
                // ),

                // Submit Button
                Container(
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      if (_formKey.currentState!.validate() &&
                              _game != "Select Game" &&
                              _gamePlayers.length >= 2
                          // _player1 != "Select Player1" &&
                          // _player2 != "Select Player2"
                          ) {
                        save(
                          // name: _nameController.text,
                          gameName: _game,
                          players: _gamePlayers,
                          // players: _gamePlayers,
                          // player1Name: _player1,
                          // player2Name: _player2,
                          // player1Id: _id1,
                          // player2Id: _id2,
                          // endScore: _endScore,
                          lowScore: _lowScore,
                          // freePlay: _freePlay,
                          gameId: _gameid,
                        );
                      } else
                        _warnDialog();
                    },
                    style: ElevatedButton.styleFrom(
                      onPrimary: Colors.white,
                      primary: Theme.of(context).colorScheme.secondaryContainer,
                    ),
                    icon: Icon(Icons.games),
                    label: Text('Submit'),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
