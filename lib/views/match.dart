import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:score/controllers/providers.dart';
import '../helpers/custom_widgets/winner_dialog.dart';

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
                var _index = gameData.match
                    .indexWhere((element) => element.id == matchId);
                if (_index == -1) {
                  _index = 0;
                }
                // print(
                //     'Match, This is the index $_index for the current id $matchId');
                final _gameName = gameData.match[_index].gameName;
                final _winScore = gameData.match[_index].winScore;
                final _freePlay = gameData.match[_index].freePlay;
                final _lowScore = gameData.match[_index].lowScore;
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _freePlay == true
                        ? TextButton(
                            onPressed: () {
                              context.read(matchProvider).changeCompleteStatus(
                                    matchId,
                                    gameData.match[_index].isComplete,
                                  );
                              String winner = "_";
                              int player1Score =
                                  gameData.match[_index].player1Score;
                              int player2Score =
                                  gameData.match[_index].player2Score;
                              if (_lowScore == false &&
                                  player1Score > player2Score) {
                                winner = gameData.match[_index].player1Name;
                              } else if (_lowScore == false &&
                                  player1Score < player2Score) {
                                winner = gameData.match[_index].player2Name;
                              } else if (_lowScore == true &&
                                  player1Score < player2Score) {
                                winner = gameData.match[_index].player1Name;
                              } else if (_lowScore == true &&
                                  player1Score > player2Score) {
                                winner = gameData.match[_index].player2Name;
                              }
                              context
                                  .read(matchProvider)
                                  .updateWinner(matchId, winner);
                              print("winner of match $matchId is $winner");
                              WinnerConfig.winDialog(context, winner);
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
                    TextButton(
                      onPressed: () {},
                      child: Text('$_gameName',
                          style: Theme.of(context).textTheme.headline3),
                    ),
                    // Select Player
                    _freePlay == true
                        ? Text('Free Play',
                            style: Theme.of(context).textTheme.headline3)
                        : Text('$_winScore',
                            style: Theme.of(context).textTheme.headline3)
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
