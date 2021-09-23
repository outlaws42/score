import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:score/controllers/providers.dart';
import 'package:score/models/match_model.dart';
import '../helpers/custom_widgets/add_subtract_dialog.dart';

class PlayerTileNo extends StatelessWidget {
  final String player;
  final int arguments;
  PlayerTileNo({
    this.player = "select Player",
    this.arguments = 1,
  });

  final Color currentColor = Colors.green;
  // String dataFromPlayer = "Select Player";
  // final String _player = 'Select Player';
  // final int _score = 0;

  // void plusOne() {
  //   setState(() {
  //     _score++;
  //   });
  //   // print(_score);
  // }

  // void minusOne() {
  //   setState(() {
  //     _score--;
  //   });
  //   // context.read(playerProvider).edit;
  //   // print(_score);
  // }

  void changeColor( Color color) {
    // setState(() => currentColor = color);
    // context.read(matchProvider).match[_index]
    print(color.value);
    print("Put int color change logic");
    Get.back();
  }

  // void goToPlay() async {
  //   var dataFromPlayer = await Get.toNamed(
  //     "/players",
  //     arguments: ['player_tile', 'Players'],
  //   );
  //   print(dataFromPlayer);
  //   _player = dataFromPlayer[0];
  //   var _id = dataFromPlayer[1];
  //   var _ts = dataFromPlayer[2];
  //   print(_id);
  //   setState(() {});
  // }

  void checkWinner(
    BuildContext context,
    score,
    currentPlayer,
    winningScore,
    sign,
  ) {
    // _winDialog(context, currentPlayer);
    if (score + 1 == winningScore) {
      context.read(matchProvider).updateWinner(arguments, currentPlayer);
      // context.read(playerProvider).updateWins(arguments, currentPlayer);

      context.read(matchProvider).fetchMatch();
      _winDialog(context, currentPlayer);
    }
    if (sign == "plus") {
      context.read(matchProvider).plus(
          id: arguments,
          score: score,
          player: player,
          addAmount: 1,
        );
    } else if (sign == "minus") {
      context.read(matchProvider).minus(
          id: arguments,
          score: score,
          player: player,
          minusAmount: 1,
        );
    } else print("sign isn't valid");
    
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

  void _colorDialog(BuildContext context, matchData, player, id, playerColor) {
    Get.defaultDialog(
      radius: 10.0,
      title: "Select Color",
      content: SingleChildScrollView(
        child: BlockPicker(
          pickerColor: Color(playerColor).withOpacity(1),
          onColorChanged: (color) { 
            matchData.changeTileColor(color, player, id);
            Get.back();
            },
          // colorPickerWidth: 300.0,
          // pickerAreaHeightPercent: 0.25,
          // enableAlpha: true,
          // displayThumbColor: true,
          // showLabel: true,
          // paletteType: PaletteType.hsv,
          // pickerAreaBorderRadius: const BorderRadius.all(
          //   Radius.circular(10.0)
          // ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //final firstName = Provider.of<PlayerProvider>(context, listen: false).fetchPlayer();
    // var _names = Provider.of<PlayerProvider>(context, listen: false).fetchPlayer() ;
    // print("This is names $players");

    return Consumer(builder: (context, watch, child) {
      final matchData = watch(matchProvider);
      var _index =
          matchData.match.indexWhere((element) => element.id == arguments);
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
        constraints: BoxConstraints(maxHeight: 130),
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
                  height:45,
                  color: Colors.black12,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Select Player
                      TextButton(
                        onPressed: () {}, //goToPlay(),
                        // child: dataFromPlayer == ""
                        //     ? Text('$player',
                        //         style: Theme.of(context).textTheme.headline3)
                        child: Text('$playerName',
                            style: Theme.of(context).textTheme.headline3),
                      ),

                      // Color Picker
                      TextButton(
                        onPressed: _isComplete == true
                            ? null
                            :() => _colorDialog(context, matchData,player, arguments,_color),
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
                    Container(
                      // color: Colors.blue,
                      child: TextButton(
                        onPressed: _isComplete == true || _score == 0
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
                            :() => DialogConfig.mathDialog(
                          context: context,
                          score: _score,
                          player: player,
                          id: arguments,
                          playerName: playerName,
                          sign: "minus",
                          winScore: winScore,
                        ),
                        child: Icon(Icons.exposure_minus_1),
                        style: ElevatedButton.styleFrom(
                          // primary: Theme.of(context).appBarTheme.backgroundColor,
                          onPrimary: Colors.white,
                        ),
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
                          :() => DialogConfig.mathDialog(
                        context: context,
                        score: _score,
                        player: player,
                        id: arguments,
                        playerName: playerName,
                        sign: "add",
                        winScore: winScore,
                      ),
                      child: Icon(Icons.plus_one),
                      style: ElevatedButton.styleFrom(
                        // primary: Theme.of(context).appBarTheme.backgroundColor,
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
