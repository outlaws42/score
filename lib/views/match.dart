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
                final playerData = watch(playerProvider);
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
                final _player1Id = gameData.match[_index].player1Id;
                final _player2Id = gameData.match[_index].player2Id;
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
                              int playerId = 0;
                              int player1Score =
                                  gameData.match[_index].player1Score;
                              int player2Score =
                                  gameData.match[_index].player2Score;
                              if (_lowScore == false &&
                                  player1Score > player2Score) {
                                winner = gameData.match[_index].player1Name;
                                playerId = _player1Id;
                              } else if (_lowScore == false &&
                                  player1Score < player2Score) {
                                winner = gameData.match[_index].player2Name;
                                playerId = _player2Id;
                              } else if (_lowScore == true &&
                                  player1Score < player2Score) {
                                winner = gameData.match[_index].player1Name;
                                playerId = _player1Id;
                              } else if (_lowScore == true &&
                                  player1Score > player2Score) {
                                winner = gameData.match[_index].player2Name;
                                playerId = _player2Id;
                              }
                              var _playerIndex = playerData.player.indexWhere(
                                  (element) => element.id == playerId);
                              final _wins =
                                  playerData.player[_playerIndex].wins;
                              context
                                  .read(matchProvider)
                                  .updateWinner(matchId, winner);

                              print("winner of match $matchId is $winner");
                              WinnerConfig.winDialog(context, winner);
                              context.read(playerProvider).plus(
                                    id: playerId,
                                    wins: _wins,
                                    addAmount: 1,
                                  );
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
                    Text('$_gameName',
                        style: Theme.of(context).textTheme.headline3),

                    // Select Player
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
                                style: Theme.of(context).textTheme.headline3)),
                    // ),
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
