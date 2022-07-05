import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:get/get.dart';
import '../controllers/providers.dart';
import '../helpers.dart';

class GameForm extends ConsumerStatefulWidget {
  @override
  _GameFormState createState() => _GameFormState();
}

class _GameFormState extends ConsumerState<GameForm> {
  List arguments = Get.arguments;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController(
    text: "This game will challenge you",
  );
  TextEditingController _desUrlController = TextEditingController();

  int _lowScoreInt = 0;

  final _formKey = GlobalKey<FormState>();

  void _save(
    WidgetRef ref,
    String name,
    String description,
    String desUrl,
    int lowScore,
  ) {
    // Save for each field save
    if (name.isEmpty) {
      return;
    }
    final lowScoreSwitch = lowScore == 0 ? false : true;

    if (arguments[0] == "form_edit") {
      ref.read(gameProvider).updateGame(
            gameId: arguments[1],
            name: name,
            description: description,
            lowScore: lowScore,
          );
    } else {
      ref.read(gameProvider).addGame(
            name: name,
            description: description,
            desUrl: desUrl,
            lowScore: lowScoreSwitch,
          );
    }

    Get.back(result: "game_form");
  }

  @override
  Widget build(BuildContext context) {
    if (arguments[0] == "form_edit") {
      _nameController = TextEditingController(
        text: arguments[2].toString(),
      );
      _descriptionController = TextEditingController(
        text: arguments[3].toString(),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          arguments[0] == "form_edit" ? "Edit Game" : "Add Game",
          style: Theme.of(context).textTheme.headline3,
        ),
        actions: [
          PageWidgets().iconButtonBarDocs(
            context: context,
            data: "assets/help_game_form.md",
            icon: Icon(MdiIcons.help),
            iconSize: 20,
          ),
        ],
      ),
      body: Consumer(builder: (context, ref, child) {
        final gameData = ref.watch(gameProvider);
        final _isLowScore =
            arguments[0] == 'form_edit' ? arguments[5] : gameData.isLowScore;

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
                FormWidgets.formTextInputValidation(
                  context: context,
                  controller: _nameController,
                  labelText: "Game",
                  hintText: "The name of your game (Required)",
                  maxLength: 20,
                  blankFieldMessage: "Please input a name for your game",
                ),
                // Description
                FormWidgets.formTextInputMulti(
                  context: context,
                  controller: _descriptionController,
                  labelText: "Description",
                  hintText: 'A description of your game (optional)',
                  maxLength: 200,
                ),
                // Description URL
                FormWidgets.formTextInput(
                  context: context,
                  controller: _desUrlController,
                  labelText: "Game Play URL",
                  hintText: "Url That would describe the game",
                  maxLength: 200,
                ),

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
                          _lowScoreInt = boolVal == false ? 0 : 1;
                          ref.read(gameProvider).updateLowScore();
                        },
                        activeTrackColor:
                            Theme.of(context).colorScheme.secondary,
                        activeColor:
                            Theme.of(context).colorScheme.primaryContainer,
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
                        _save(
                          ref,
                          _nameController.text,
                          _descriptionController.text,
                          _desUrlController.text,
                          _lowScoreInt,
                        );
                        if (_isLowScore == true) {
                          ref.read(gameProvider).updateLowScore();
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      onPrimary: Colors.white,
                      primary: Theme.of(context).appBarTheme.backgroundColor,
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
