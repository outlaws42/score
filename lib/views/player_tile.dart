import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:score/controllers/providers.dart';
import '../helpers/custom_widgets/add_subtract_dialog.dart';

class PlayerTile extends StatelessWidget {
  final String player;
  final int matchId;
  PlayerTile({
    this.player = "select Player",
    this.matchId = 1,
  });

  // final Color currentColor = Colors.green;

  void checkWinner(
    BuildContext context,
    score,
    currentPlayer,
    winningScore,
    sign,
  ) {
    // _winDialog(context, currentPlayer);
    if (score + 1 == winningScore) {
      context.read(matchProvider).updateWinner(matchId, currentPlayer);
      // context.read(playerProvider).updateWins(arguments, currentPlayer);

      context.read(matchProvider).fetchMatch();
      _winDialog(context, currentPlayer);
    }
    if (sign == "plus") {
      context.read(matchProvider).plus(
            id: matchId,
            score: score,
            player: player,
            addAmount: 1,
          );
    } else if (sign == "minus") {
      context.read(matchProvider).minus(
            id: matchId,
            score: score,
            player: player,
            minusAmount: 1,
          );
    } else
      print("sign isn't valid");
  }

  void _winDialog(BuildContext context, currentPlayer) {
    Get.defaultDialog(
      radius: 10.0,
      title: "The Game Is Complete",
      content: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.beach_access,
                color: Colors.green,
              ),
              Text(
                " $currentPlayer",
                style: Theme.of(context).textTheme.headline5,
              ),
              Text(" Won The Game"),
            ],
          ),
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

  void _colorDialog(
    BuildContext context,
    matchData,
    player,
    id,
    playerColor,
  ) {
    Get.defaultDialog(
      radius: 10.0,
      title: "Select Color",
      content: BlockPicker(
        pickerColor: Color(playerColor).withOpacity(1),
        onColorChanged: (color) {
          matchData.changeTileColor(color, player, id);
          Get.back();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final matchData = watch(matchProvider);
      var _index =
          matchData.match.indexWhere((element) => element.id == matchId);
      if (_index == -1) {
        _index = 0;
      }
      final _isComplete = matchData.match[_index].isComplete;
      // print('This is the index $_index for the current id $arguments');
      // print('This is the isComplete $_isComplete');

      final winScore = matchData.match[_index].winScore;
      // print('This is the winScore $winScore');
      final playerName = player == "player1"
          ? matchData.match[_index].player1Name
          : matchData.match[_index].player2Name;
      final _score = player == "player1"
          ? matchData.match[_index].player1Score
          : matchData.match[_index].player2Score;
      final _color = player == "player1"
          ? matchData.match[_index].player1Color
          : matchData.match[_index].player2Color;
      // print(matchData.match[_index].player1Score);
      // print(matchData.match[_index].player2Score);
      // print("${matchData.match[_index].winner} Won the Game");
      // if (_score == matchData.match[_index].winScore) {
      //   context.read(matchProvider).updateWinner(arguments, playerName);
      //   print("${matchData.match[_index].winner} Won the Game");
      // }

      return Container(
        constraints: BoxConstraints(maxHeight: 145),
        child: Card(
          elevation: 6,
          color: Color(_color).withOpacity(1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Row Top Name/Menu
              Container(
                // padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Container(
                  // padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  height: 45,
                  // color: Colors.black12,
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Select Player
                      Text(
                        '$playerName',
                        style: Theme.of(context).textTheme.headline3,
                      ),

                      // Color Picker
                      TextButton(
                        onPressed: _isComplete == true
                            ? null
                            : () => _colorDialog(
                                context, matchData, player, matchId, _color),
                        child: Icon(Icons.color_lens),
                        style: ElevatedButton.styleFrom(
                          // primary: Theme.of(context).appBarTheme.backgroundColor,
                          onPrimary: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Row 2 minus button score positive button
              Container(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Minus Button
                    TextButton(
                      onPressed: _isComplete == true
                          ? null
                          : () => checkWinner(
                              context, _score, playerName, winScore, "minus"),
                      // onPressed: () => context.read(matchProvider).minus(
                      //       id: arguments,
                      //       score: _score,
                      //       player: player,
                      //       minusAmount: 1,
                      //     ),
                      onLongPress: _isComplete == true
                          ? null
                          : () => DialogConfig.mathDialog(
                                context: context,
                                score: _score,
                                player: player,
                                id: matchId,
                                playerName: playerName,
                                sign: "minus",
                                winScore: winScore,
                              ),
                      child: Icon(Icons.remove),

                      style: ElevatedButton.styleFrom(
                        primary: Colors.black12,
                        onPrimary: Colors.white,
                      ),
                    ),
                    Text(
                      '$_score',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    // }),
                    // Plus Button
                    TextButton(
                      onPressed: _isComplete == true
                          ? null
                          : () => checkWinner(
                              context, _score, playerName, winScore, "plus"),
                      // onPressed: () => context.read(matchProvider).plus(
                      //       id: arguments,
                      //       score: _score,
                      //       player: player,
                      //       addAmount: 1,
                      //     ),
                      onLongPress: _isComplete == true
                          ? null
                          : () => DialogConfig.mathDialog(
                                context: context,
                                score: _score,
                                player: player,
                                id: matchId,
                                playerName: playerName,
                                sign: "add",
                                winScore: winScore,
                              ),
                      child: Icon(Icons.add),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black12,
                        onPrimary: Colors.white,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
