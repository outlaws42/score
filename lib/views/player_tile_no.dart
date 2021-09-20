import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:score/controllers/providers.dart';
import 'package:score/models/match_model.dart';
import '../helpers/custom_widgets/add_subtract_dialog.dart';

class PlayerTileNo extends StatelessWidget {
  final String player;
  final int id;
  PlayerTileNo({
    this.player = "select Player",
    this.id = 1,
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

  void changeColor(Color color) {
    // setState(() => currentColor = color);
    print(color.toString());
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

  void _colorDialog() {
    Get.defaultDialog(
      title: "Select Color",
      content: BlockPicker(
        pickerColor: currentColor,
        onColorChanged: changeColor,
        // colorPickerWidth: 300.0,
        // pickerAreaHeightPercent: 0.5,
        // enableAlpha: true,
        // displayThumbColor: true,
        // showLabel: true,
        // paletteType: PaletteType.hsv,
        // pickerAreaBorderRadius: const BorderRadius.all(
        //   Radius.circular(10.0)
        // ),
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
      var _index = matchData.match.indexWhere((element) => element.id == id);
      if (_index == -1) {
        _index = 0;
      }
      print('This is the index $_index for the current id $id');
      final playerName = player == "player1"
          ? matchData.match[_index].player1Name
          : matchData.match[_index].player2Name;
      final _score = player == "player1"
          ? matchData.match[_index].player1Score
          : matchData.match[_index].player2Score;
      // print(matchData.match[_index].player1Score);
      // print(matchData.match[_index].player2Score);
      // if (matchData.match[_index].player1Score ==
      //         matchData.match[_index].winScore ||
      //     matchData.match[_index].player2Score ==
      //         matchData.match[_index].winScore) {
      //   print("Won the Game");
      // }

      return Container(
        constraints: BoxConstraints(maxHeight: 130),
        child: Card(
          elevation: 6,
          color: currentColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Row Top Name/Menu
              Container(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
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
                      onPressed: () => _colorDialog(),
                      child: Icon(Icons.color_lens),
                      style: ElevatedButton.styleFrom(
                        // primary: Theme.of(context).appBarTheme.backgroundColor,
                        onPrimary: Colors.white,
                      ),
                    ),
                  ],
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
                      onPressed: () => context.read(matchProvider).minus(
                            id: id,
                            score: _score,
                            player: player,
                            minusAmount: 1,
                          ),
                      onLongPress: () => DialogConfig.mathDialog(
                        context: context,
                        score: _score,
                        player: player,
                        id: id,
                        playerName: playerName,
                        sign: "minus",
                      ),
                      child: Icon(Icons.exposure_minus_1),
                      style: ElevatedButton.styleFrom(
                        // primary: Theme.of(context).appBarTheme.backgroundColor,
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
                      onPressed: () => context.read(matchProvider).plus(
                            id: id,
                            score: _score,
                            player: player,
                            addAmount: 1,
                          ),
                      onLongPress: () => DialogConfig.mathDialog(
                        context: context,
                        score: _score,
                        player: player,
                        id: id,
                        playerName: playerName,
                        sign: "add",
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
