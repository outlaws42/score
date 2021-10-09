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
    List args = const ["form"],
  }) {
    return IconButton(
      onPressed: () => Get.toNamed(pageLink, arguments: args),
      icon: icon,
      iconSize: 30,
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
            // Text(
            //   'Tap',
            //   style: Theme.of(context).textTheme.headline5,
            // ),
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
    // List _oLPSelectedItems = [];
    List arguments = Get.arguments;
    final _name = player[index].name;
    final _wins = player[index].wins;
    final _id = player[index].id;
    bool _isSelected = player[index].isSelected;
    return GestureDetector(
      onTap: () {
        if (arguments[0] == 'player_tile' || arguments[0] == 'form') {
          _selectedItems = [_name, _id];
          // print(_selectedItems);
          Get.back(result: _selectedItems);
        } else {
          // print(arguments[0]);
          BottomSheetWidgets().playerSheet(
              buildContext: context,
              playerId: _id,
              matchList: matchList,
              playerName: _name);
        }
        print("This is onTap");
      },
      onLongPress: () {
        context.read(playerProvider).updateSelected(
              playerId: _id,
              isSelected: _isSelected,
            );
        print("This is onLongPress");
      },
      child: Container(
          padding: const EdgeInsets.all(2),
          // margin: const EdgeInsets.all(10),
          height: 70,
          child: Card(
            // margin: const EdgeInsets.all(10),
            elevation: 3,
            color: _isSelected == false
                ? Theme.of(context).scaffoldBackgroundColor
                : Theme.of(context).appBarTheme.backgroundColor,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Leading
                  _isSelected == true
                      ? Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                PopupDialogWidgets.warnDialog(
                                    context, _name, _id);
                                // context.read(playerProvider).deletePlayer(_id);
                                print("Pressed Delete");
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

                                print("Pressed Edit");
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
                  //Title(Player Name)
                  Text(
                    '$_name',
                    style: _isSelected == false
                        ? Theme.of(context).textTheme.headline4
                        : Theme.of(context).textTheme.headline5,
                  ),
                  Spacer(
                    flex: 1,
                  ),
                  // Trailing
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
    final _freePlay = game[index].freePlay;
    bool _isSelected = game[index].isSelected;
    final _date =
        FunctionHelper().convertToDate(dateTimeUtcInt: game[index].dateTime);
    String _firstDesc = "";

    if (_description.length > 29) {
      _firstDesc = _description.substring(0, 29);
    } else {
      _firstDesc = _description;
    }

    return GestureDetector(
      onTap: () {
        print("OnTap");
        if (arguments[0] == 'form') {
          _selectedItems = [_game, _endScore, _id, _lowScore, _freePlay];
          print(_selectedItems);
          Get.back(result: _selectedItems);
        } else {
          print(arguments[0]);
          BottomSheetWidgets().gameSheet(
            context: context,
            game: _game,
            description: _description,
            date: _date,
            // _endScore,
            // _id,
          );
        }
      },
      onLongPress: () {
        print("This is ID $_id");
        context.read(gameProvider).updateSelected(
              gameId: _id,
              isSelected: _isSelected,
            );
        print("This is onLongPress");
      },
      child: Container(
        padding: const EdgeInsets.all(2),
        height: 70,
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
                // Leading
                _isSelected == true
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                            onPressed: () {
                              PopupDialogWidgets.warnDialog(
                                  context, _game, _id);
                              // context.read(playerProvider).deletePlayer(_id);
                              print("Pressed Delete");
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
                                _description
                              ]);

                              print("Pressed Edit");
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
                //Title(Player Name)
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
                _freePlay == true
                    ? Row(
                        children: [
                          PageWidgets().circleContainer(
                            context: context,
                            content: 'FP',
                          ),
                          _lowScore == true
                              ? PageWidgets().circleContainer(
                                  context: context,
                                  content: 'LS',
                                )
                              : Container(
                                  height: 0,
                                  width: 0,
                                ),
                        ],
                      )
                    : PageWidgets().circleContainer(
                        context: context,
                        content: _endScore.toString(),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
