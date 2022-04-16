import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:score/controllers/providers.dart';
import 'package:score/helpers/function_helpers.dart';
import '../helpers/custom_widgets/page_widgets.dart';

class Match extends StatelessWidget {
  final String matchId;
  Match({
    this.matchId = "_",
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
                  // Get rid of error when it is the only item until db can assing id
                  _index = 0;
                }
                final _isComplete = gameData.match[_index].isComplete;
                final _gameName = gameData.match[_index].gameName;
                final _winScore = gameData.match[_index].winScore;
                // final _freePlay = gameData.match[_index].freePlay;
                final _player1Id = gameData.match[_index].players;
                final _player2Id = gameData.match[_index].players;
                final _player1Score = gameData.match[_index].players;
                final _player2Score = gameData.match[_index].players;
                bool scoreCheck = true;
                final _lowScore = gameData.match[_index].lowScore;
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                            onPressed: _isComplete == true ||
                                    scoreCheck == false
                                ? null
                                : () {
                                    FunctionHelper.checkWinner(
                                        context: context,
                                        player1Score:
                                            0, // gameData.match[_index].player1Score,
                                        player2Score:
                                            0, // gameData.match[_index].player2Score,
                                        player1Id: '0', // _player1Id,
                                        player2Id: '2', //_player2Id,
                                        player1Name:
                                            'Troy', // gameData.match[_index].players,
                                        player2Name:
                                            'Cara',// gameData.match[_index].player2Name,
                                        lowScore:
                                            gameData.match[_index].lowScore,
                                        matchId: matchId);
                                  },
                            child: Icon(Icons.done),
                            style: ElevatedButton.styleFrom(
                              onPrimary: Colors.white,
                            ),
                          ),
                        // : Container(
                        //     height: 0,
                        //     width: 0,
                        //   ),
                    // Winning Score/Free Play
                    Text('$_gameName',
                        style: Theme.of(context).textTheme.headline3),

                    // Win Score/Free Play
                    Spacer(),
                    PageWidgets().circleOulineContainer(
                      context: context,
                      content: _winScore.toString(),
                    ),
                    _lowScore == true
                        ? PageWidgets().circleOulineContainer(
                            context: context,
                            content: 'LS',
                          )
                        : Container(
                            height: 0,
                            width: 0,
                          ),
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
