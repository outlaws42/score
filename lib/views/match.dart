import 'dart:math';
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
                final _players = gameData.match[_index].players;
                final _lowScore = gameData.match[_index].lowScore;

                // final _winScore = gameData.match[_index].winScore;
                // final _freePlay = gameData.match[_index].freePlay;
                // final _player1Id = gameData.match[_index].players;
                // final _player2Id = gameData.match[_index].players;
                // final _player1Score = gameData.match[_index].players;
                // final _player2Score = gameData.match[_index].players;
                // var play = [];
                // for(var i in gameData.match[_index].players){
                //   play.add(i.score);
                //   // print(i.score);
                // }
                int _winScore = 0;
                bool scoreCheck = false;
 
                 if (_lowScore == true) {
                  _winScore = _players.map((abc) => abc.score).reduce(min);
                } else {
                  _winScore = _players.map((abc) => abc.score).reduce(max);
                }
                
                // int res = gameData.match[_index].players.map((element) => element.score == _winScore ? 1 : 0).reduce((value, element) => value + element);
                var _winScoreTimes = _players.where((element) => element.score == _winScore);
                print('indexScore Length: ${_winScoreTimes.length}');
                // print('res: ${res}');
                if (_winScoreTimes.length > 1 ) {
                  scoreCheck = false;
                } else {
                  scoreCheck = true;
                }
                // print(_winScore);
                // print('indexScore ${indexScore.length}');
                // bool scoreCheck = true;
                // final _lowScore = gameData.match[_index].lowScore;
                // print('This is the matchId: $matchId');
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
                                        // player1Score:
                                        //     0, // gameData.match[_index].player1Score,
                                        // player2Score:
                                        //     0, // gameData.match[_index].player2Score,
                                        // player1Id: '0', // _player1Id,
                                        // player2Id: '2', //_player2Id,
                                        // player1Name:
                                        //     'Troy', // gameData.match[_index].players,
                                        // player2Name:
                                        //     'Cara',// gameData.match[_index].player2Name,
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

                    // Low Score/High Score
                    Spacer(),
                    
                    _lowScore == true
                        ? PageWidgets().circleOulineContainer(
                            context: context,
                            content: 'LS',
                          )
                        : PageWidgets().circleOulineContainer(
                      context: context,
                      content: 'HS',
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
