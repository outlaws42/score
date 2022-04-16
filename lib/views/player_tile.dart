import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:score/controllers/providers.dart';
import '../helpers.dart';

class PlayerTile extends StatelessWidget {
  final String player;
  final String matchId;
  PlayerTile({
    this.player = "select Player",
    this.matchId = "",
  });

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
      final _freePlay = true; //matchData.match[_index].freePlay;
      final _lowScore = false; //matchData.match[_index].lowScore;
      final _isComplete = matchData.match[_index].isComplete;
      final _player1Name = 'Troy'; //matchData.match[_index].player1Name;
      final _player2Name = 'Cara'; //matchData.match[_index].player2Name;
      final _player1Score = 0; //matchData.match[_index].player1Score;
      final _player2Score = 0; //matchData.match[_index].player2Score;
      final _player1Id = '0'; //matchData.match[_index].player1Id;
      final _player2Id = '1'; //matchData.match[_index].player2Id;
      final winScore = matchData.match[_index].winScore;
      final playerName = player == "player1" ? _player1Name : _player2Name;
      final _score = player == "player1" ? _player1Score : _player2Score;
      final _color = player == "player1"
          ? 0 //matchData.match[_index].player1Color
          : 1; //matchData.match[_index].player2Color;

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
                                    player: player,
                                    minusAmount: 1,
                                  );
                              if (_freePlay == true) {
                                return;
                              }
                              if (_score + 1 == winScore) {
                                FunctionHelper.checkWinner(
                                  context: context,
                                  player1Name: _player1Name,
                                  player2Name: _player2Name,
                                  matchId: matchId,
                                  player1Id: _player1Id,
                                  player2Id: _player2Id,
                                  player1Score: _player1Score,
                                  player2Score: _player2Score,
                                  lowScore: _lowScore,
                                );
                              }
                            },
                      onLongPress: _isComplete == true
                          ? null
                          : () async{
                             await  PopupDialogWidgets.mathDialog(
                                context: context,
                                score: _score,
                                player: player,
                                playerIndex: 1,
                                id: matchId,
                                // playerName: playerName,
                                sign: "minus",
                                winScore: winScore,
                                freePlay: _freePlay,
                                // index: _index,
                                // player1Name: _player1Name, 
                                // player2Name: _player2Name,
                                // player1Id: _player1Id,
                                // player2Id: _player2Id,
                                // player1Score: _player1Score,
                                // player2Score: _player2Score,
                                lowScore: _lowScore,
                              );
                              // print('This is score before return $_score');
                              // if (_freePlay == true) {
                              //   return;
                              // }
                              // print('This is score after return $_score');
                              // if (_score + 1 == winScore) {
                                // FunctionHelper.checkWinner(
                                //   context: context, X
                                //   player1Name: _player1Name, 
                                //   player2Name: _player2Name,
                                //   matchId: matchId, X
                                //   player1Id: _player1Id,
                                //   player2Id: _player2Id,
                                //   player1Score: _player1Score,
                                //   player2Score: _player2Score,
                                //   lowScore: _lowScore,
                                // );
                              // }
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
                                    player: player,
                                    addAmount: 1,
                                  );
                              if (_freePlay == true) {
                                return;
                              }
                              if (_score + 1 == winScore) {
                                FunctionHelper.checkWinner(
                                  context: context,
                                  player1Name: _player1Name,
                                  player2Name: _player2Name,
                                  matchId: matchId,
                                  player1Id: _player1Id,
                                  player2Id: _player2Id,
                                  player1Score: _player1Score,
                                  player2Score: _player2Score,
                                  lowScore: _lowScore,
                                );
                              }
                            },
                      onLongPress: _isComplete == true
                          ? null
                          : () => PopupDialogWidgets.mathDialog(
                                context: context,
                                score: _score,
                                player: player,
                                playerIndex: 1,
                                id: matchId,
                                // playerName: playerName,
                                sign: "add",
                                winScore: winScore,
                                freePlay: _freePlay,
                                // player1Name: _player1Name, 
                                // player2Name: _player2Name,
                                // player1Id: _player1Id,
                                // player2Id: _player2Id,
                                // player1Score: _player1Score,
                                // player2Score: _player2Score,
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
