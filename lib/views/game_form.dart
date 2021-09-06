import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import './game_screen.dart';

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
    Get.back(result: "game_form");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Player"),
      ),
      body: Consumer(
        builder: (context, ScopedReader watch, child) {
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
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: TextFormField(
                      controller: _nameController,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "Fill in the name of the game";
                        }
                        return null;
                      },
                      maxLength: 20,
                      textCapitalization: TextCapitalization.words,
                      textInputAction: TextInputAction.next,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        decorationColor: Colors.teal,
                      ),
                      decoration: InputDecoration(
                        labelText: "Game",
                        labelStyle: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        hintText: 'The name of your game (Required)',
                        hintStyle: TextStyle(
                          color: Theme.of(context).colorScheme.secondaryVariant,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.primaryVariant,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),

                  // Description
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: TextFormField(
                      controller: _descriptionController,
                      maxLength: 40,
                      textCapitalization: TextCapitalization.words,
                      textInputAction: TextInputAction.next,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        decorationColor: Colors.teal,
                      ),
                      decoration: InputDecoration(
                        labelText: "Description",
                        labelStyle: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        hintText: 'A breif description of your game (optional)',
                        hintStyle: TextStyle(
                          color: Theme.of(context).colorScheme.secondaryVariant,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.primaryVariant,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),

                  // End Score
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: TextFormField(
                      controller: _endscoreController,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "Fill in the winning score";
                        }
                        return null;
                      },
                      maxLength: 4,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        decorationColor: Colors.teal,
                      ),
                      decoration: InputDecoration(
                        labelText: "Winning Points",
                        labelStyle: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        hintText:
                            'How many points needed to win the game (Required)',
                        hintStyle: TextStyle(
                          color: Theme.of(context).colorScheme.secondaryVariant,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.primaryVariant,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
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
                          activeTrackColor: Theme.of(context).colorScheme.secondary,
                          activeColor: Theme.of(context).colorScheme.primaryVariant,
                        ),
                      ],
                    ),
                  ),
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
        }
      ),
    );
  }
}
