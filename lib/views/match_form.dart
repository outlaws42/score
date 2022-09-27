import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import '../helpers/screen.dart';
import '../controllers/providers.dart';
import '../helpers.dart';

class MatchForm extends ConsumerStatefulWidget {
  @override
  _MatchFormState createState() => _MatchFormState();
}

class _MatchFormState extends ConsumerState<MatchForm> {
  final _formKey = GlobalKey<FormState>();

  String _game = 'Select Game';
  String _gameid = "";
  bool _lowScore = false;
  String? selected;
  List _gamePlayers = [];

  void goToGame() async {
    var dataFromGame = await Get.toNamed(
      "/game_select",
      arguments: ['form', ''],
    );
    _game = dataFromGame[0];
    _gameid = dataFromGame[1];
    _lowScore = dataFromGame[2];
    setState(() {});
  }

  void goToPlay() async {
    var dataFromPlayer = await Get.toNamed(
      "/players_select",
      arguments: ['form', ''],
    );
    for (var item in dataFromPlayer) {
      _gamePlayers.add(item);
    }
    print(_gamePlayers);
    setState(() {});
  }

  Future<void> save({
    required WidgetRef ref,
    required String gameName,
    required String gameId,
    required List<dynamic> players,
    bool lowScore = false,
  }) async {
    await ref.read(matchProvider).addMatchHttp(
          gameName: gameName,
          players: players,
        );
    int _date = ref.read(matchProvider).match.length > 0
        ? ref.read(matchProvider).match.last.dateTime
        : 1;
    var _index = ref
        .read(matchProvider)
        .match
        .indexWhere((match) => match.dateTime == _date);

    String _id = ref.read(matchProvider).match[_index].id;
    Get.offAllNamed("/match_current", arguments: [_id, "match_form"]);
  }

  void _warnDialog() {
    Get.defaultDialog(
      radius: 10.0,
      title: "Warning",
      backgroundColor: Theme.of(context).appBarTheme.foregroundColor,
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

  void _colorDialog({
    required BuildContext context,
    players,
    playerIndex,
    playerColor,
  }) {
    Get.defaultDialog(
      radius: 10.0,
      title: "Select Color",
      content: BlockPicker(
        pickerColor: Color(playerColor).withOpacity(1),
        onColorChanged: (color) {
          setState(() {
            players[playerIndex]['color'] = color.value;
          });
          Get.back();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print(Screen.height(context));
    double boxHeight = (Screen.height(context) / 2) - 20.0;
    print(boxHeight);
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
      body: Consumer(builder: (context, WidgetRef ref, child) {
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

                // Game Selection
                Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Card(
                    color: Theme.of(context).appBarTheme.foregroundColor,
                    elevation: 4,
                    child: ListTile(
                      title: Text('$_game',
                          style: Theme.of(context).textTheme.headline4),
                      trailing: Icon(
                        Icons.games,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      onTap: () => goToGame(),
                    ),
                  ),
                ),

                // players Selection
                _gamePlayers.length == 0
                    ? Container(
                        margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Card(
                          color: Theme.of(context).appBarTheme.foregroundColor,
                          elevation: 4,
                          child: ListTile(
                              title: Text('Select Players',
                                  style: Theme.of(context).textTheme.headline4),
                              trailing: Icon(
                                Icons.person_add,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              onTap: () {
                                goToPlay();
                              }),
                        ),
                      )
                    : Column(
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: Card(
                              color:
                                  Theme.of(context).appBarTheme.foregroundColor,
                              elevation: 4,
                              child: ListTile(
                                title: Text('Selected Players',
                                    style:
                                        Theme.of(context).textTheme.headline4),
                                trailing: Icon(
                                  Icons.person_add,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                onTap: () {
                                  _gamePlayers = [];
                                  // _gamePlayersId = [];
                                  goToPlay();
                                },
                              ),
                            ),
                          ),
                          // Selected Players and Tile Colors
                          SizedBox(
                            height: boxHeight,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: _gamePlayers.length,
                              itemBuilder: (ctx, index) {
                                return ListTile(
                                  leading: Material(
                                    type: MaterialType.transparency,
                                    child: Ink(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        // set the border
                                        border: Border.all(
                                            width: 2, color: Colors.black),
                                        // border radius
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        // background color
                                        color:
                                            Color(_gamePlayers[index]['color']),
                                      ),
                                      child: InkWell(
                                        borderRadius:
                                            BorderRadius.circular(100.0),
                                        onTap: () {
                                          _colorDialog(
                                              context: context,
                                              playerColor: _gamePlayers[index]
                                                  ['color'],
                                              playerIndex: index,
                                              players: _gamePlayers);
                                        },
                                      ),
                                    ),
                                  ),
                                  title: Text(
                                    _gamePlayers[index]['player_name'],
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                );
                              },
                              physics: const BouncingScrollPhysics(
                                parent: AlwaysScrollableScrollPhysics(),
                              ),
                            ),
                          ),
                        ],
                      ),

                // Submit Button
                Container(
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      if (_formKey.currentState!.validate() &&
                          _game != "Select Game" &&
                          _gamePlayers.length >= 2) {
                        save(
                          ref: ref,
                          gameName: _game,
                          players: _gamePlayers,
                          lowScore: _lowScore,
                          gameId: _gameid,
                        );
                      } else
                        _warnDialog();
                    },
                    style: ElevatedButton.styleFrom(
                      onPrimary: Colors.white,
                      primary: Theme.of(context).appBarTheme.backgroundColor,
                      // primary: Theme.of(context).colorScheme.secondaryContainer,
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
