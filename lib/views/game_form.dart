import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import '../controllers/providers.dart';
import '../helpers/custom_widgets/form_text_input.dart';

class GameForm extends StatefulWidget {
  @override
  State<GameForm> createState() => _GameFormState();
}

class _GameFormState extends State<GameForm> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController(
    text: "This game will challenge you",
  );
  final _endscoreController = TextEditingController(text: '21');
  // final _lowScoreController = TextEditingController(text: '0');

  int lowScoreInt = 0;

  final _formKey = GlobalKey<FormState>();

  void saveEach(String name, String description, int endscore, int lowscore) {
    // Save for each field save
    if (name.isEmpty) {
      return;
    }
    final lowscoreSwitch = lowscore == 0 ? false : true;
    context.read(gameProvider).addGameForm(
          name: name,
          description: description,
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
        title: Text("Add Game"),
      ),
      body: Consumer(builder: (context, ScopedReader watch, child) {
        final gameData = watch(gameProvider);
        final _isLowScore = gameData.isLowScore;
        final _isFreePlay = gameData.isFreePlay;
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
                FormConfigInput.formTextInputValidation(
                    context: context,
                    controller: _nameController,
                    labelText: "Game",
                    hintText: "The name of your game (Required)",
                    maxLength: 20,
                    blankFieldMessage: "Please input a name for your game"),
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

                // Free Playe (Toggle)
                Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Free Play',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Switch(
                        value: _isFreePlay,
                        onChanged: (boolVal) {
                          lowScoreInt = boolVal == false ? 0 : 1;
                          print(lowScoreInt);
                          context.read(gameProvider).updateFreePlay();
                        },
                        activeTrackColor:
                            Theme.of(context).colorScheme.secondary,
                        activeColor:
                            Theme.of(context).colorScheme.primaryVariant,
                      ),
                    ],
                  ),
                ),

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
                          _nameController.text,
                          _descriptionController.text,
                          int.parse(
                            _endscoreController.text,
                          ),
                          lowScoreInt,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      onPrimary: Colors.white,
                      primary: Theme.of(context).appBarTheme.backgroundColor,
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
