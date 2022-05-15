import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:score/controllers/providers.dart';
import '../helpers.dart';

class PlayerTileUpdate extends StatelessWidget {
  final String player;
  final String matchId;
  final int playerIndex;
  final int playerScore;
  final int playerColor;
  PlayerTileUpdate({
    required this.player,
    required this.matchId,
    required this.playerIndex,
    required this.playerScore,
    required this.playerColor,
  });

  void _colorDialog({
    required BuildContext context,
    matchData,
    player,
    playerIndex,
    id,
    playerColor,
  }) {
    Get.defaultDialog(
      radius: 10.0,
      title: "Select Color",
      content: BlockPicker(
        pickerColor: Color(playerColor).withOpacity(1),
        onColorChanged: (color) {
          matchData.changeTileColor(
            color: color,
            player: player,
            playerIndex: playerIndex,
            id: id,
          );
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
      final _lowScore = matchData.match[_index].lowScore;
      final _isComplete = matchData.match[_index].isComplete;
      final _score = playerScore; 
      final _color = matchData.match[_index].players[playerIndex].color;


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
                child: Container(
                  height: 45,
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
                        '$player',
                        style: Theme.of(context).textTheme.headline3,
                      ),

                      // Color Picker
                      TextButton(
                        onPressed: _isComplete == true
                            ? null
                            : () => _colorDialog(
                                  context: context,
                                  matchData: matchData,
                                  player: player,
                                  playerIndex: playerIndex,
                                  id: matchId,
                                  playerColor: _color,
                                ),
                        child: Icon(Icons.color_lens),
                        style: ElevatedButton.styleFrom(
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
                          : () {
                              context.read(matchProvider).minus(
                                    id: matchId,
                                    score: _score,
                                    playerIndex: playerIndex,
                                    player: player,
                                    minusAmount: 1,
                                  );
                            },
                      // Score minus button long press pop up dialog     
                      onLongPress: _isComplete == true
                          ? null
                          : () async {
                              await PopupDialogWidgets.mathDialog(
                                context: context,
                                score: _score,
                                player: player,
                                playerIndex: playerIndex,
                                id: matchId,
                                sign: "minus",
                                lowScore: _lowScore,
                              );
                            },
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
                    // Plus Button
                    TextButton(
                      onPressed: _isComplete == true
                          ? null
                          : () {
                              context.read(matchProvider).plus(
                                    id: matchId,
                                    score: _score,
                                    playerIndex: playerIndex,
                                    player: player,
                                    addAmount: 1,
                                  );
                            },
                      // Score Plus button long press pop up dialog 
                      onLongPress: _isComplete == true
                          ? null
                          : () => PopupDialogWidgets.mathDialog(
                                context: context,
                                score: _score,
                                player: player,
                                playerIndex: playerIndex,
                                id: matchId,
                                sign: "add",
                                lowScore: _lowScore,
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
