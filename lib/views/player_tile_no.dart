import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:score/controllers/providers.dart';

class PlayerTileNo extends StatelessWidget {
  final String player;
  PlayerTileNo({this.player = "select Player"});

  final Color currentColor = Colors.green;
  // String dataFromPlayer = "Select Player";
  final String _player = 'Select Player';
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

  // void changeColor(Color color) {
  //   setState(() => currentColor = color);
  //   Get.back();
  // }

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

  // void _showDialog() {
  //   Get.defaultDialog(
  //       title: "Select Color",
  //       content: BlockPicker(
  //         pickerColor: currentColor,
  //         onColorChanged: changeColor,
  //         // colorPickerWidth: 300.0,
  //         // pickerAreaHeightPercent: 0.5,
  //         // enableAlpha: true,
  //         // displayThumbColor: true,
  //         // showLabel: true,
  //         // paletteType: PaletteType.hsv,
  //         // pickerAreaBorderRadius: const BorderRadius.all(
  //         //   Radius.circular(10.0)
  //         // ),
  //       ));
  // }

  @override
  Widget build(BuildContext context) {
    //final firstName = Provider.of<PlayerProvider>(context, listen: false).fetchPlayer();
    // var _names = Provider.of<PlayerProvider>(context, listen: false).fetchPlayer() ;
    // print("This is names $players");

    return Consumer(builder: (context, watch, child) {
      final matchData = watch(matchProvider);
      final players = player == "player1"
          ? matchData.match[1].player1Name
          : matchData.match[1].player2Name;
      final _score = player == "player1"
          ? matchData.match[0].player1Score
          : matchData.match[0].player2Score;
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
                      child: Text('$players',
                          style: Theme.of(context).textTheme.headline3),
                    ),

                    // Color Picker
                    TextButton(
                      onPressed: () {}, //_showDialog(),
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
                      onPressed: () =>
                          context.read(matchProvider).minusOne(1, _score, player),
                      onLongPress: () {},
                      child: Icon(Icons.exposure_minus_1),
                      style: ElevatedButton.styleFrom(
                        // primary: Theme.of(context).appBarTheme.backgroundColor,
                        onPrimary: Colors.white,
                      ),
                    ),
                    Consumer(builder: (context, watch, child) {
                      final playerData = watch(playerProvider);

                      return player == "player1" ?Text(
                        '${matchData.match[0].player1Score}', // '$_score',
                        style: Theme.of(context).textTheme.headline1,
                      ) : Text(
                        '${matchData.match[0].player2Score}', // '$_score',
                        style: Theme.of(context).textTheme.headline1,
                      );
                    }),
                    // Plus Button
                    TextButton(
                      onPressed: () =>
                          context.read(matchProvider).plusOne(1, _score,player),
                      onLongPress: () {},
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
