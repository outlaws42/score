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
import '../screen.dart';

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
      color: Colors.white,
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
      color: Colors.white,
    );
  }

  // Widget header(
  //     {required BuildContext context,
  //     required String column1,
  //     required String column2}) {
  //   return Card(
  //     elevation: 6,
  //     color: Theme.of(context).appBarTheme.backgroundColor,
  //     child: ListTile(
  //       title: Text('$column1', style: Theme.of(context).textTheme.headline3),
  //       trailing:
  //           Text('$column2', style: Theme.of(context).textTheme.headline3),
  //     ),
  //   );
  // }

  Widget header2({
    required BuildContext context,
    required String column1,
    required String column2,
    String column3 = '_',
  }) {
    return Card(
      elevation: 6,
      color: Theme.of(context).appBarTheme.backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Container(
              width: 80,
              child:
                  Text(column1, style: Theme.of(context).textTheme.headline3),
            ),
            Spacer(
              flex: 1,
            ),
            column3 == '_'
                ? Container(
                    width: 80,
                  )
                : Container(
                    width: 80,
                    child: Text(column3,
                        style: Theme.of(context).textTheme.headline3),
                  ),
            Spacer(
              flex: 1,
            ),
            Container(
              width: 60,
              child:
                  Text(column2, style: Theme.of(context).textTheme.headline3),
            ),
          ],
        ),
      ),
    );
  }

  Widget headerButton(
      {required WidgetRef ref,
      required BuildContext context,
      required String column1,
      required String column2}) {
    final quantityPlayers = ref.read(playerProvider).selectedPlayers.length;
    return Card(
      elevation: 6,
      color: Theme.of(context).appBarTheme.backgroundColor,
      child: ListTile(
        leading: TextButton(
          onPressed: quantityPlayers >= 2
              ? () async {
                  var _playersSelect = ref.read(playerProvider).selectedPlayers;
                  Get.back(result: _playersSelect);

                  var _playerSelectIds = [];
                  for (var i in _playersSelect) {
                    _playerSelectIds.add(i['player_id']);
                  }

                  for (var item in _playerSelectIds) {
                    ref.read(playerProvider).updateSelected(
                          playerId: item,
                          isSelected: true,
                        );
                  }
                  ref.read(playerProvider).removeAllPlayers();
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
    required WidgetRef ref,
    required BuildContext context,
    required int index,
    required List<PlayerModel> player,
    required List<MatchModel> matchList,
    required PlayerProvider playerProv,
  }) {

    final _name = player[index].name;
    final _wins = player[index].wins;
    final _matches = player[index].matches;
    final _id = player[index].id;
    bool _isSelected = player[index].isSelected;
    return GestureDetector(
      onTap: () {
        BottomSheetWidgets().playerSheet(
              buildContext: context,
              playerId: _id,
              matchList: matchList,
              playerName: _name);
      },
      child: Container(
          padding: const EdgeInsets.all(2),
          constraints: BoxConstraints(
            minHeight: 70,
          ),
          child: Card(
            elevation: 3,
            color: _isSelected == false
                ? Theme.of(context).appBarTheme.foregroundColor
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
                                  ref,
                                  context,
                                  _name,
                                  _id,
                                  "player",
                                );
                              },
                              icon: Icon(Icons.delete_forever),
                              iconSize: 30,
                              color:
                                  Theme.of(context).appBarTheme.foregroundColor,
                            ),
                            IconButton(
                              onPressed: () {
                                ref.read(playerProvider).updateSelected(
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
                  Container(
                    width: 55,
                    // height: 55,
                    child: Text(
                      '$_name',
                      style: _isSelected == false
                          ? Theme.of(context).textTheme.headline4
                          : Theme.of(context).textTheme.headline5,
                    ),
                  ),
                  Spacer(
                    flex: 1,
                  ),
                  PageWidgets().circleContainer(
                    context: context,
                    content: _matches.toString(),
                  ),
                  Spacer(
                      // flex: 1,
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
    required WidgetRef ref,
    required BuildContext context,
    required int index,
    required List<GameModel> game,
  }) {
    List _selectedItems = [];
    List arguments = Get.arguments ?? ['matchScreen'];
    final _id = game[index].id;
    final _game = game[index].name;
    final _description = game[index].description;
    final _endScore = game[index].endScore;
    final _lowScore = game[index].lowScore;
    final _url = game[index].desUrl;
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
            url: _url,
            date: _date,
          );
        }
      },
      onLongPress: () {
        ref.read(gameProvider).updateSelected(
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
              ? Theme.of(context).appBarTheme.foregroundColor
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
                                ref,
                                context,
                                _game,
                                _id,
                                "game",
                              );
                            },
                            icon: Icon(Icons.delete_forever),
                            iconSize: 30,
                            color:
                                Theme.of(context).appBarTheme.foregroundColor,
                          ),
                          IconButton(
                            onPressed: () {
                              ref.read(playerProvider).updateSelected(
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
    required WidgetRef ref,
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
    int divFactor = 3; // Divide factor. Number of columns except when select then 4
    if (_isSelected == true) {
      divFactor = 4;
    }
    final width = Screen.width(context);
    final widthAdj = (width / divFactor) - 17;

    return GestureDetector(
      onTap: () {
        Get.offAllNamed("/match_current", arguments: [
          _id,
        ]);
      },
      onLongPress: () {
        if (_isComplete == false) {
          ref.read(matchProvider).updateSelected(
                matchId: _id,
                isSelected: _isSelected,
              );
        }
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _isSelected == true
                    ? Container(
                        width: 55,
                        child: Column(
                          children: [
                            // Container(
                            //   height: 75,
                            //   width: 55,
                            IconButton(
                              // label: Text('Delete'),
                              icon: Icon(
                                Icons.delete_forever,
                                color: Colors.red,
                                size: 40,
                              ),
                              onPressed: () {
                                PopupDialogWidgets.warnDialog(
                                  ref,
                                  context,
                                  _gameName,
                                  _id,
                                  'match',
                                );
                              },
                            ),
                            // ),
                          ],
                        ),
                      )
                    : Container(),
                // 1st column (Game and players)
                Container(
                  width: widthAdj,
                  // decoration: BoxDecoration(border: Border.all()),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 35,
                        width: 120,
                        child: Text(
                          '$_gameName        ',
                          style: _isSelected == true
                              ? Theme.of(context).textTheme.headline5
                              : Theme.of(context).textTheme.headline4,
                        ),
                      ),
                      for (var player in players)
                        Text(
                          '$player',
                          style: _isSelected == true
                              ? Theme.of(context).textTheme.subtitle2
                              : Theme.of(context).textTheme.subtitle1,
                        ),
                    ],
                  ),
                ),
                // Spacer(
                //   flex: 1,
                // ),
                // 2nd column (Winner and complete)
                Container(
                  width: widthAdj,
                  // decoration: BoxDecoration(border: Border.all()),
                  // mainAxisAlignment: MainAxisAlignment.start,
                  child: _isComplete == true
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 35,
                              width: 80,
                              child: PageWidgets().squareContainer(
                                  context: context, content: '$_winner'),
                            ),
                            // Container(
                            //   height: 35,
                            //   width: 80,
                            //   child: Text(
                            //     'Complete',
                            //     style: _isSelected == true
                            //         ? Theme.of(context).textTheme.subtitle2
                            //         : Theme.of(context).textTheme.subtitle1,
                            //   ),
                            // )
                          ],
                        )
                      : Container(
                          height: 35,
                          width: 75,
                        ),
                  // ],
                ),
                // Spacer(
                //   flex: 1,
                // ),
                // 3rd Column
                Container(
                  width: widthAdj,
                  // decoration: BoxDecoration(border: Border.all()),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _lowScore == true
                          ? Container(
                              height: 35,
                              width: 60,
                              child: PageWidgets().circleContainer(
                                context: context,
                                content: 'LS',
                              ),
                            )
                          : Container(
                              height: 35,
                              width: 60,
                              child: PageWidgets().circleContainer(
                                context: context,
                                content: 'HS',
                              ),
                            ),
                      Container(
                        height: 35,
                        width: 90,
                        child: Text(
                          '$_date',
                          style: _isSelected == true
                              ? Theme.of(context).textTheme.subtitle2
                              : Theme.of(context).textTheme.subtitle1,
                        ),
                      )
                    ],
                  ),
                )
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
    required WidgetRef ref,
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
        ref.read(playerProvider).updateGamePlayers(
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
                    ref.read(playerProvider).updateGamePlayers(
                          playerName: _name,
                          playerId: _id,
                          isSelected: _isSelected,
                        );

                  },
                  activeTrackColor: Theme.of(context).colorScheme.secondary,
                  activeColor: Theme.of(context).colorScheme.primaryContainer,
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
