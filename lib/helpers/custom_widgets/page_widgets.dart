import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import './popup_dialog_widgets.dart';
import '../../controllers/providers.dart';
import '../../controllers/player_provider.dart';
import '../../models/match_model.dart';
import '../../models/player_model.dart';
import '../../models/game_model.dart';
import '../function_helpers.dart';
import './bottom_sheet_widgets.dart';

class PageWidgets {
  Widget iconButtonBar({
    required BuildContext context,
    required String pageLink,
    required Icon icon,
    double iconSize = 30,
    List args = const ["form"],
  }) {
    return IconButton(
      onPressed: () => Get.toNamed(pageLink, arguments: args),
      icon: icon,
      iconSize: iconSize,
      color: Theme.of(context).appBarTheme.foregroundColor,
    );
  }

  Widget iconButtonBarDocs({
    required BuildContext context,
    required String data,
    required Icon icon,
    double iconSize = 30,
    double popupHeightPercent = 75,
    double popupWidthPercent = 90,
  }) {
    
    return IconButton(
      onPressed: () => PopupDialogWidgets.documentation(
        context: context,
        data: data,
        popupHeightPercent: popupHeightPercent,
        popupWidthPercent: popupWidthPercent,
      ),
      icon: icon,
      iconSize: iconSize,
      color: Theme.of(context).appBarTheme.foregroundColor,
    );
  }

  Widget header(
      {required BuildContext context,
      required String column1,
      required String column2}) {
    return Card(
      elevation: 6,
      color: Theme.of(context).appBarTheme.backgroundColor,
      child: ListTile(
        title: Text('$column1', style: Theme.of(context).textTheme.headline3),
        trailing:
            Text('$column2', style: Theme.of(context).textTheme.headline3),
      ),
    );
  }

  Widget headerButton(
      {required BuildContext context,
      required String column1,
      required String column2}) {
    final quantityPlayers = context.read(playerProvider).selectedPlayers.length;
    return Card(
      elevation: 6,
      color: Theme.of(context).appBarTheme.backgroundColor,
      child: ListTile(
        leading: TextButton(
          onPressed: quantityPlayers >= 2
              ? () async {
                  var _playersSelect =
                      context.read(playerProvider).selectedPlayers;
                  Get.back(result: _playersSelect);

                  var _playerSelectIds = [];
                  for (var i in _playersSelect) {
                    _playerSelectIds.add(i['player_id']);
                  }

                  print('_playerSelectIds: $_playerSelectIds');
                  // print('_playerSelect: $_playersSelect');
                  for (var item in _playerSelectIds) {
                    context.read(playerProvider).updateSelected(
                          playerId: item,
                          isSelected: true,
                        );
                  }
                  context.read(playerProvider).removeAllPlayers();
                }
              : null,
          child: Icon(Icons.done),
          style: ElevatedButton.styleFrom(
            onPrimary: Colors.white,
          ),
        ),
        title: Text(
          '$column1',
          style: Theme.of(context).textTheme.headline3,
        ),
        trailing: Text(
          '$column2',
          style: Theme.of(context).textTheme.headline3,
        ),
      ),
    );
  }

  Widget noData({
    required BuildContext context,
    required String pageName,
    required String pageLink,
    List args = const ["form"],
  }) {
    return Center(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () => Get.toNamed(pageLink, arguments: args),
              icon: Icon(Icons.add_circle),
              iconSize: 120,
              color: Theme.of(context).appBarTheme.backgroundColor,
            ),
            Text(
              'Tap to add your first $pageName',
              style: Theme.of(context).textTheme.headline2,
            ),
          ],
        ),
      ),
    );
  }

  Widget circleContainer({
    required BuildContext context,
    required String content,
  }) {
    return Container(
      alignment: Alignment.center,
      height: 30,
      width: 30,
      margin: EdgeInsets.all(2),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).appBarTheme.backgroundColor,
          boxShadow: [
            BoxShadow(color: Colors.black26, blurRadius: 2.0),
          ]),
      child: Text(
        content,
        style: Theme.of(context).textTheme.headline5,
      ),
    );
  }

  Widget squareContainer({
    required BuildContext context,
    required String content,
  }) {
    return Container(
      alignment: Alignment.center,
      height: 30,
      width: 75,
      margin: EdgeInsets.all(2),
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Theme.of(context).appBarTheme.backgroundColor,
          borderRadius: BorderRadius.circular(5.0),
          boxShadow: [
            BoxShadow(color: Colors.black26, blurRadius: 5.0),
          ]),
      child: Text(
        content,
        style: Theme.of(context).textTheme.headline5,
      ),
    );
  }

  Widget circleOulineContainer({
    required BuildContext context,
    required String content,
  }) {
    return Container(
      alignment: Alignment.center,
      height: 32,
      width: 32,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white,
          width: 2,
        ),
      ),
      child: Text(
        content,
        style: Theme.of(context).textTheme.headline3,
      ),
    );
  }

  Widget listItemPlayer({
    required BuildContext context,
    required int index,
    required List<PlayerModel> player,
    required List<MatchModel> matchList,
    required PlayerProvider playerProv,
  }) {
    List _selectedItems = [];
    List arguments = Get.arguments;
    final _name = player[index].name;
    final _wins = player[index].wins;
    final _id = player[index].id;
    bool _isSelected = player[index].isSelected;
    return GestureDetector(
      onTap: () {
        if (arguments[0] == 'player_tile' || arguments[0] == 'form') {
          _selectedItems = [_name, _id];
          Get.back(result: _selectedItems);
        } else {
          BottomSheetWidgets().playerSheet(
              buildContext: context,
              playerId: _id,
              matchList: matchList,
              playerName: _name);
        }
      },
      child: Container(
          padding: const EdgeInsets.all(2),
          constraints: BoxConstraints(
            minHeight: 70,
          ),
          child: Card(
            elevation: 3,
            color: _isSelected == false
                ? Theme.of(context).scaffoldBackgroundColor
                : Theme.of(context).appBarTheme.backgroundColor,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _isSelected == true
                      ? Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                PopupDialogWidgets.warnDialog(
                                    context, _name, _id, "player");
                              },
                              icon: Icon(Icons.delete_forever),
                              iconSize: 30,
                              color:
                                  Theme.of(context).appBarTheme.foregroundColor,
                            ),
                            IconButton(
                              onPressed: () {
                                context.read(playerProvider).updateSelected(
                                      playerId: _id,
                                      isSelected: _isSelected,
                                    );
                                Get.toNamed("/player_form", arguments: [
                                  "form_edit",
                                  _id,
                                  _name,
                                  _wins
                                ]);
                              },
                              icon: Icon(Icons.edit),
                              iconSize: 30,
                              color:
                                  Theme.of(context).appBarTheme.foregroundColor,
                            ),
                          ],
                        )
                      : Container(
                          height: 0,
                          width: 0,
                        ),
                  Text(
                    '$_name',
                    style: _isSelected == false
                        ? Theme.of(context).textTheme.headline4
                        : Theme.of(context).textTheme.headline5,
                  ),
                  Spacer(
                    flex: 1,
                  ),
                  PageWidgets().circleContainer(
                    context: context,
                    content: _wins.toString(),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  Widget listItemGame({
    required BuildContext context,
    required int index,
    required List<GameModel> game,
  }) {
    List _selectedItems = [];
    List arguments = Get.arguments;
    final _id = game[index].id;
    final _game = game[index].name;
    final _description = game[index].description;
    final _endScore = game[index].endScore;
    final _lowScore = game[index].lowScore;
    // final _freePlay = game[index].freePlay;
    bool _isSelected = game[index].isSelected;
    final _date = FunctionHelper().intUtcToStringFormatDT(
      dateTimeUtcInt: game[index].dateTime,
    );
    String _firstDesc = "";

    if (_description.length > 29) {
      _firstDesc = _description.substring(0, 29);
    } else {
      _firstDesc = _description;
    }

    return GestureDetector(
      onTap: () {
        if (arguments[0] == 'form') {
          _selectedItems = [
            _game,
            _id,
            _lowScore,
          ];
          Get.back(result: _selectedItems);
        } else {
          BottomSheetWidgets().gameSheet(
            context: context,
            game: _game,
            description: _description,
            date: _date,
          );
        }
      },
      onLongPress: () {
        context.read(gameProvider).updateSelected(
              gameId: _id,
              isSelected: _isSelected,
            );
      },
      child: Container(
        padding: const EdgeInsets.all(2),
        constraints: BoxConstraints(
          minHeight: 70,
        ),
        child: Card(
          elevation: 3,
          color: _isSelected == false
              ? Theme.of(context).scaffoldBackgroundColor
              : Theme.of(context).appBarTheme.backgroundColor,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _isSelected == true
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                            onPressed: () {
                              PopupDialogWidgets.warnDialog(
                                  context, _game, _id, "game");
                            },
                            icon: Icon(Icons.delete_forever),
                            iconSize: 30,
                            color:
                                Theme.of(context).appBarTheme.foregroundColor,
                          ),
                          IconButton(
                            onPressed: () {
                              context.read(playerProvider).updateSelected(
                                    playerId: _id,
                                    isSelected: _isSelected,
                                  );
                              Get.toNamed("/game_form", arguments: [
                                "form_edit",
                                _id,
                                _game,
                                _description,
                                _endScore,
                                _lowScore,
                                // _freePlay
                              ]);
                            },
                            icon: Icon(Icons.edit),
                            iconSize: 30,
                            color:
                                Theme.of(context).appBarTheme.foregroundColor,
                          ),
                        ],
                      )
                    : Container(
                        height: 0,
                        width: 0,
                      ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$_game',
                      style: _isSelected == false
                          ? Theme.of(context).textTheme.headline4
                          : Theme.of(context).textTheme.headline5,
                    ),
                    Text(
                      '$_firstDesc',
                      style: _isSelected == false
                          ? Theme.of(context).textTheme.bodyText1
                          : Theme.of(context).textTheme.bodyText2,
                    ),
                  ],
                ),
                Spacer(
                  flex: 1,
                ),
                // _freePlay == true
                Row(
                  children: [
                    _lowScore == true
                        ? PageWidgets().circleContainer(
                            context: context,
                            content: 'LS',
                          )
                        : PageWidgets().circleContainer(
                            context: context,
                            content: 'HS',
                          ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget listItemMatch({
    required BuildContext context,
    required int index,
    required List<MatchModel> match,
    required List players,
  }) {
    final _id = match[index].id;
    final _gameName = match[index].gameName;
    final _lowScore = match[index].lowScore;
    final _winner = match[index].winner;
    final _isComplete = match[index].isComplete;
    final _isSelected = match[index].isSelected;
    final _date = FunctionHelper().intUtcToStringFormatDT(
      dateTimeUtcInt: match[index].dateTime,
    );

    return GestureDetector(
      onTap: () {
        Get.offAllNamed("/match_current", arguments: [
          _id,
        ]);
      },
      onLongPress: () {
        context.read(matchProvider).updateSelected(
              matchId: _id,
              isSelected: _isSelected,
            );
      },
      child: Container(
        padding: const EdgeInsets.all(2),
        constraints: BoxConstraints(
          minHeight: 80,
        ),
        child: Card(
          elevation: 3,
          color: _isSelected == false
              ? Theme.of(context).appBarTheme.foregroundColor
              : Theme.of(context).appBarTheme.backgroundColor,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
            child: Row(
              children: [
                _isSelected == true
                    ? IconButton(
                        onPressed: () {
                          PopupDialogWidgets.warnDialog(
                            context,
                            _gameName,
                            _id,
                            "match",
                          );
                        },
                        icon: Icon(Icons.delete_forever),
                        iconSize: 30,
                        color: Theme.of(context).appBarTheme.foregroundColor,
                      )
                    : Container(height: 0, width: 0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(

                          child: Text(
                            '$_gameName        ',
                            style: _isSelected == true
                                ? Theme.of(context).textTheme.headline5
                                : Theme.of(context).textTheme.headline4,
                          ),
                        ),
                        _isComplete == true
                        ? Container(
                          child: PageWidgets().squareContainer(
                              context: context,
                              content: '$_winner'
                          )
                        ) 
                        
                        : Container(),

                      ],
                    ),
                    Row(
                      children: [
                        for (var player in players)
                          Text(
                            '$player, ',
                            style: _isSelected == true
                                ? Theme.of(context).textTheme.subtitle2
                                : Theme.of(context).textTheme.subtitle1,
                          )
                      ],
                    ),
                  ],
                ),
                Spacer(
                  flex: 1,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _lowScore == true
                        ? PageWidgets().circleContainer(
                            context: context,
                            content: 'LS',
                          )
                        : PageWidgets().circleContainer(
                            context: context,
                            content: 'HS',
                          ),
                    Text(
                      '$_date',
                      style: _isSelected == true
                          ? Theme.of(context).textTheme.subtitle2
                          : Theme.of(context).textTheme.subtitle1,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Widget settingsCategoryHeader({
    required BuildContext context,
    required String sectionTitle,
  }) {
    return Container(
      color: Theme.of(context).colorScheme.onPrimary,
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Text(
            sectionTitle,
            style: Theme.of(context).textTheme.headline6,
          ),
        ],
      ),
    );
  }

  static Widget settingHr() {
    return Divider(
      height: 5,
      thickness: 2,
      indent: 0,
      endIndent: 0,
    );
  }

  static Widget settingsItemIcon({
    required BuildContext context,
    required String title,
    required String action,
    Icon icon = const Icon(Icons.file_upload),
    String subtitle = "",
  }) {
    return ListTile(
      title: Text(
        title,
        style: Theme.of(context).textTheme.headline6,
      ),
      subtitle: Text(
        subtitle,
        style: Theme.of(context).textTheme.bodyText1,
      ),
      trailing: icon,
      onTap: () async {
        if (action == "export") {
          String url = await FunctionHelper().backupDb(
            context: context,
          );
          BottomSheetWidgets().dbBackupSheet(context: context, url: url);
        } else if (action == "share") {
          FunctionHelper().shareDb(
            context: context,
          );
        } else if (action == "import") {
          PopupDialogWidgets.confirmBackupDialog(
            context: context,
            dbFile: "Test",
          );
        }
      },
    );
  }

  Widget selectPlayer({
    required BuildContext context,
    required int index,
    required List<PlayerModel> player,
    required List<MatchModel> matchList,
    required PlayerProvider playerProv,
  }) {

    final _name = player[index].name;
    final _wins = player[index].wins;
    final _id = player[index].id;
    bool _isSelected = player[index].isSelected;
    return GestureDetector(
      onTap: () {
        context.read(playerProvider).updateGamePlayers(
              playerName: _name,
              playerId: _id,
              isSelected: _isSelected,
            );
      },
      child: Container(
        padding: const EdgeInsets.all(2),
        constraints: BoxConstraints(
          minHeight: 70,
        ),
        child: Card(
          elevation: 3,
          color: _isSelected == false
              ? Theme.of(context).scaffoldBackgroundColor
              : Theme.of(context).appBarTheme.backgroundColor,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Switch(
                  value: _isSelected,
                  onChanged: (boolVal) {
                    // _freePlayInt = boolVal == false ? 0 : 1;
                    context.read(playerProvider).updateGamePlayers(
                          playerName: _name,
                          playerId: _id,
                          isSelected: _isSelected,
                        );
                    // print(_isSelected);
                  },
                  activeTrackColor: Theme.of(context).colorScheme.secondary,
                  activeColor: Theme.of(context).colorScheme.primaryVariant,
                ),
                Text(
                  '$_name',
                  style: _isSelected == false
                      ? Theme.of(context).textTheme.headline4
                      : Theme.of(context).textTheme.headline5,
                ),
                Spacer(
                  flex: 1,
                ),
                PageWidgets().circleContainer(
                  context: context,
                  content: _wins.toString(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
