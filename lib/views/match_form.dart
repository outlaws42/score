import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import '../controllers/providers.dart';
import '../helpers/custom_widgets/form_text_input.dart';

class MatchForm extends StatefulWidget {
  @override
  State<MatchForm> createState() => _MatchFormState();
}

class _MatchFormState extends State<MatchForm> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController(
    text: "This game will challenge you",
  );
  final _endscoreController = TextEditingController(text: '21');
  // final _lowScoreController = TextEditingController(text: '0');

  int lowScoreInt = 0;

  final _formKey = GlobalKey<FormState>();

  String _game = 'Select Game';
  int _endScore = 0;
  int _gameid = 0;

  void goToGame() async {
    var dataFromGame = await Get.toNamed(
      "/games",
      arguments: ['match', ''],
    );
    print(dataFromGame);
    _game = dataFromGame[0];
    _endScore = dataFromGame[1];
    _gameid = dataFromGame[2];
    print(_gameid);
    setState(() {});
  }

  void saveEach({
    String? name,
    String? game,
    int? endscore,
    int? lowscore,
    int? gamid,
  }) {
    // Save for each field save
    if (game == null || game.isEmpty) {
      return;
    }
    final lowscoreSwitch = lowscore == 0 ? false : true;
    context.read(gameProvider).addGameForm(
          name: name,
          description: game,
          endscore: endscore,
          lowscore: lowscoreSwitch,
        );
    context.read(gameProvider).fetchGame();
    Get.back(result: "game_form");
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
                TextButton(
                  onPressed: () => goToGame(),
                  // child: dataFromPlayer == ""
                  //     ? Text('$player',
                  //         style: Theme.of(context).textTheme.headline3)
                  child: Text('$_game',
                      style: Theme.of(context).textTheme.headline3),
                ),

                // Description
                FormConfigInput.formTextInputMulti(
                  context: context,
                  controller: _descriptionController,
                  labelText: "Description",
                  hintText: 'A description of your game (optional)',
                  maxLength: 200,
                ),

                // End Score
                FormConfigInput.formTextInputValidation(
                    context: context,
                    controller: _endscoreController,
                    labelText: "Winning Points",
                    hintText:
                        'How many points needed to win the game (Required)',
                    maxLength: 20,
                    blankFieldMessage: "Please fill in the winning score"),

                // Low Score Wins (Toggle)
                Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Low Score Wins',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Switch(
                        value: _isLowScore,
                        onChanged: (boolVal) {
                          lowScoreInt = boolVal == false ? 0 : 1;
                          print(lowScoreInt);
                          context.read(gameProvider).updateLowScore();
                        },
                        activeTrackColor:
                            Theme.of(context).colorScheme.secondary,
                        activeColor:
                            Theme.of(context).colorScheme.primaryVariant,
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
                        saveEach(
                          name: _nameController.text,
                          game: _descriptionController.text,
                          endscore: _endScore,
                          lowscore: lowScoreInt,
                          gamid: 0,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      onPrimary: Colors.white,
                      primary: Theme.of(context).colorScheme.secondaryVariant,
                    ),
                    icon: Icon(Icons.games),
                    label: Text('Add Game'),
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
