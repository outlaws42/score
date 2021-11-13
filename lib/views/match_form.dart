import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:get/get.dart';
import '../controllers/providers.dart';
import '../helpers.dart';

class MatchForm extends StatefulWidget {
  @override
  State<MatchForm> createState() => _MatchFormState();
}

class _MatchFormState extends State<MatchForm> {
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String _game = 'Select Game';
  String _player1 = 'Select Player1';
  String _player2 = 'Select Player2';
  int _id1 = 0;
  int _id2 = 0;
  int _endScore = 0;
  int _gameid = 0;
  bool _lowScore = false;
  bool _freePlay = false;
  String? selected;

  void goToGame() async {
    var dataFromGame = await Get.toNamed(
      "/games",
      arguments: ['form', ''],
    );
    _game = dataFromGame[0];
    _endScore = dataFromGame[1];
    _gameid = dataFromGame[2];
    _lowScore = dataFromGame[3];
    _freePlay = dataFromGame[4];
    setState(() {});
  }

  void goToPlay(String player, otherId) async {
    var dataFromPlayer = await Get.toNamed(
      "/players_select",
      arguments: ['form', '$otherId'],
    );
    // if (player == "player1") {
    //   _player1 = dataFromPlayer[0];
    //   _id1 = dataFromPlayer[1];
    // } else if (player == "player2") {
    //   _player2 = dataFromPlayer[0];
    //   _id2 = dataFromPlayer[1];
    // }
    // setState(() {});
  }

  void save({
    String name = "",
    String? gameName,
    int? gameId,
    required String player1Name,
    required String player2Name,
    int player1Id = 0,
    int player2Id = 0,
    int endScore = 0,
    bool lowScore = false,
    bool freePlay = false,
  }) {
    // Save all fields
    if (gameName == null || gameName.isEmpty) {
      return;
    }
    int _dtUtcMs = DateTime.now().toUtc().millisecondsSinceEpoch;
    int _id = context.read(matchProvider).match.length > 0
        ? context.read(matchProvider).match.last.id + 1
        : 1;
    context.read(matchProvider).addMatch(
          matchName: name,
          gameName: gameName,
          gameId: gameId,
          player1Name: player1Name,
          player2Name: player2Name,
          player1Id: player1Id,
          player2Id: player2Id,
          endScore: endScore,
          lowScore: lowScore,
          freePlay: freePlay,
          dateTime: _dtUtcMs,
          isCompleted: false,
        );
    context.read(matchProvider).fetchMatch();
    Get.offAllNamed("/match_current", arguments: [_id, "match_form"]);
  }

  void _warnDialog() {
    Get.defaultDialog(
      radius: 10.0,
      title: "Warning",
      content: Column(
        children: [
          Text("You need to select a game and 2 players"),
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
                Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Card(
                    elevation: 4,
                    child: ListTile(
                      title: Text('$_player1',
                          style: Theme.of(context).textTheme.headline4),
                      trailing: Icon(
                        Icons.person_add,
                        color: Theme.of(context).appBarTheme.backgroundColor,
                      ),
                      onTap: () => goToPlay('player1', _id2),
                    ),
                  ),
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
                          _game != "Select Player" &&
                          _player1 != "Select Player1" &&
                          _player2 != "Select Player2") {
                        save(
                          name: _nameController.text,
                          gameName: _game,
                          player1Name: _player1,
                          player2Name: _player2,
                          player1Id: _id1,
                          player2Id: _id2,
                          endScore: _endScore,
                          lowScore: _lowScore,
                          freePlay: _freePlay,
                          gameId: _gameid,
                        );
                      } else
                        _warnDialog();
                    },
                    style: ElevatedButton.styleFrom(
                      onPrimary: Colors.white,
                      primary: Theme.of(context).colorScheme.secondaryVariant,
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
