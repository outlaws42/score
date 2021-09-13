import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import '../controllers/providers.dart';
import '../models/player_model.dart';
import '../helpers/custom_widgets/form_text_input.dart';

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
  String? selected;

  void goToGame() async {
    var dataFromGame = await Get.toNamed(
      "/games",
      arguments: ['matchForm', ''],
    );
    print(dataFromGame);
    _game = dataFromGame[0];
    _endScore = dataFromGame[1];
    _gameid = dataFromGame[2];
    _lowScore = dataFromGame[3];
    print(_gameid);
    setState(() {});
  }

  void goToPlay(String player) async {
    var dataFromPlayer = await Get.toNamed(
      "/players",
      arguments: ['player_tile', 'Players'],
    );
    if (player == "player1") {
      _player1 = dataFromPlayer[0];
      _id1 = dataFromPlayer[1];
    } else if (player == "player2") {
      _player2 = dataFromPlayer[0];
      _id2 = dataFromPlayer[1];
    }
    print(dataFromPlayer);
    
    // var _id = dataFromPlayer[1];
    // var _ts = dataFromPlayer[2];
    setState(() {});
  }

  void save({
    String name = "",
    String? game,
    String? player1Name,
    String? player2Name,
    int? player1Id,
    int? player2Id,
    int? endscore,
    bool lowscore = false,
    int? gamid,
  }) {
    // Save all fields
    if (game == null || game.isEmpty) {
      return;
    }
    context.read(matchProvider).addMatch(
          matchname: name,
          playerscore1: 0,
          playerscore2: 1,
          iscompleted: true,
        );
    context.read(matchProvider).fetchMatch();
    Get.back(result: "match_form");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Player"),
      ),
      body: Consumer(builder: (context, ScopedReader watch, child) {
        final gameData = watch(gameProvider);
        final _isLowScore = gameData.isLowScore;
        return SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'Game Information',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                // Game Name
                FormConfigInput.formTextInput(
                  context: context,
                  controller: _nameController,
                  labelText: "Match Name",
                  hintText: "The name of match (Optional)",
                  maxLength: 20,
                ),
          
                // Game Selection
                Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('$_game',
                            style: Theme.of(context).textTheme.headline5),
                    IconButton(
                        icon: Icon(Icons.games),
                        color: Theme.of(context).appBarTheme.backgroundColor,
                        onPressed: () => goToGame(),
                      ),
                    ],
                  ),
                ),

                // player1 Selection
                Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('$_player1',
                            style: Theme.of(context).textTheme.headline5),
                    IconButton(
                        icon: Icon(Icons.person_add),
                        color: Theme.of(context).appBarTheme.backgroundColor,
                        onPressed: () => goToPlay('player1'),
                      ),
                    ],
                  ),
                ),

                // player2 Selection
                Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('$_player2',
                            style: Theme.of(context).textTheme.headline5),
                    IconButton(
                        icon: Icon(Icons.person_add),
                        color: Theme.of(context).appBarTheme.backgroundColor,
                        onPressed: () => goToPlay('player2'),
                      ),
                    ],
                  ),
                ),

                

                // Submit Button
                Container(
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        save(
                          name: _nameController.text,
                          game: _game,
                          player1Name: _player1,
                          player2Name: _player2,
                          player1Id: _id1,
                          player2Id: _id2,
                          endscore: _endScore,
                          lowscore: _lowScore,
                          gamid: _gameid,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      onPrimary: Colors.white,
                      primary: Theme.of(context).colorScheme.secondaryVariant,
                    ),
                    icon: Icon(Icons.games),
                    label: Text('Add Match'),
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
