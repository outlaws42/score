import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:score/controllers/providers.dart';
import 'package:score/helpers/function_helpers.dart';

class Match extends StatelessWidget {
  final int matchId;
  Match({
    this.matchId = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: 60),
      child: Card(
        elevation: 6,
        color: Theme.of(context).appBarTheme.backgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Consumer(builder: (context, watch, child) {
                final gameData = watch(matchProvider);
                // final playerData = watch(playerProvider);
                var _index = gameData.match
                    .indexWhere((element) => element.id == matchId);
                if (_index == -1) {
                  _index = 0;
                }
                // print(
                //     'Match, This is the index $_index for the current id $matchId');
                final _isComplete = gameData.match[_index].isComplete;
                final _gameName = gameData.match[_index].gameName;
                final _winScore = gameData.match[_index].winScore;
                final _freePlay = gameData.match[_index].freePlay;
                // final _lowScore = gameData.match[_index].lowScore;
                final _player1Id = gameData.match[_index].player1Id;
                final _player2Id = gameData.match[_index].player2Id;
                final _lowScore = gameData.match[_index].lowScore;
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _freePlay == true
                        ? TextButton(
                            onPressed: _isComplete == true
                                ? null
                                : () {
                                    FunctionHelper.checkWinner(
                                        context: context,
                                        player1Score:
                                            gameData.match[_index].player1Score,
                                        player2Score:
                                            gameData.match[_index].player2Score,
                                        player1Id: _player1Id,
                                        player2Id: _player2Id,
                                        player1Name:
                                            gameData.match[_index].player1Name,
                                        player2Name:
                                            gameData.match[_index].player2Name,
                                        lowScore:
                                            gameData.match[_index].lowScore,
                                        matchId: matchId);
                                  },
                            child: Icon(Icons.done),
                            style: ElevatedButton.styleFrom(
                              // primary: Theme.of(context).appBarTheme.backgroundColor,
                              onPrimary: Colors.white,
                            ), //Text('complete',
                            //      style: Theme.of(context).textTheme.headline3),
                          )
                        : Text(""),
                    // Winning Score/Free Play
                    Spacer(),
                    Text('$_gameName',
                        style: Theme.of(context).textTheme.headline3),

                    // Win Score/Free Play
                    Spacer(),
                    Container(
                      alignment: Alignment.center,
                      height: 32,
                      width: 32,
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          )
                          // color: Theme.of(context).appBarTheme.backgroundColor,
                          // boxShadow: [
                          //   BoxShadow(color: Colors.black26, blurRadius: 8.0),
                          // ],
                          ),
                      child: _freePlay == true
                          ? Text('FP',
                              style: Theme.of(context).textTheme.headline3)
                          : Text('$_winScore',
                              style: Theme.of(context).textTheme.headline3),
                    ),
                    _lowScore == true
                        ? Container(
                            alignment: Alignment.center,
                            height: 32,
                            width: 32,
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                )
                                // color: Theme.of(context).appBarTheme.backgroundColor,
                                // boxShadow: [
                                //   BoxShadow(color: Colors.black26, blurRadius: 8.0),
                                // ],
                                ),
                            child: Text('LS',
                                style: Theme.of(context).textTheme.headline3))
                        : Text(""),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
