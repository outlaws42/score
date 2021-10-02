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

  int _lowScoreInt = 0;
  int _freePlayInt = 0;

  final _formKey = GlobalKey<FormState>();

  void _save(
    String name,
    String description,
    int endScore,
    int lowScore,
    int freePlay,
  ) {
    // Save for each field save
    if (name.isEmpty) {
      return;
    }
    final lowScoreSwitch = lowScore == 0 ? false : true;
    final freePlaySwitch = freePlay == 0 ? false : true;
    int _dtUtcMs = DateTime.now().toUtc().millisecondsSinceEpoch;
    context.read(gameProvider).addGameForm(
          name: name,
          description: description,
          endScore: endScore,
          lowScore: lowScoreSwitch,
          freePlay: freePlaySwitch,
          dateTime: _dtUtcMs,
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
                          _freePlayInt = boolVal == false ? 0 : 1;
                          print(_freePlayInt);
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

                // End Score
                _isFreePlay == false
                    ? FormConfigInput.formTextInputValidation(
                        context: context,
                        controller: _endscoreController,
                        labelText: "Winning Points",
                        hintText:
                            'How many points needed to win the game (Required)',
                        maxLength: 20,
                        blankFieldMessage: "Please fill in the winning score")
                    : Container(),

                // Low Score Wins (Toggle)
                _isFreePlay== true ? Container(
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
                          _lowScoreInt = boolVal == false ? 0 : 1;
                          print(_lowScoreInt);
                          context.read(gameProvider).updateLowScore();
                        },
                        activeTrackColor:
                            Theme.of(context).colorScheme.secondary,
                        activeColor:
                            Theme.of(context).colorScheme.primaryVariant,
                      ),
                    ],
                  ),
                ): Container(),

                // Submit Button
                Container(
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _save(
                          _nameController.text,
                          _descriptionController.text,
                          int.parse(
                            _endscoreController.text,
                          ),
                          _lowScoreInt,
                          _freePlayInt,
                        );
                        if (_isLowScore == true) { 
                          context.read(gameProvider).updateLowScore();
                        }
                        if (_isFreePlay== true) { 
                          context.read(gameProvider).updateFreePlay();
                        }
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
