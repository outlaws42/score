// import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:score/controllers/providers.dart';
import 'package:score/helpers/function_helpers.dart';
import '../helpers/custom_widgets/page_widgets.dart';
import '../helpers/custom_widgets/popup_dialog_widgets.dart';

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
              child: Consumer(builder: (context, ref, child) {
                final gameData = ref.watch(matchProvider);
                var _index = gameData.match
                    .indexWhere((element) => element.id == matchId);
                final _isComplete = gameData.match[_index].isComplete;
                final _gameName = gameData.match[_index].gameName;
                final _lowScore = gameData.match[_index].lowScore;
                int _winScore = 0;
                bool _scoreCheck = false;

                _winScore = FunctionHelper.checkWinningScore(
                  ref: ref,
                  context: context,
                  lowScore: _lowScore,
                  index: _index,
                );
                _scoreCheck = FunctionHelper.checkWinningScoreDuplicate(
                  ref: ref,
                  context: context,
                  index: _index,
                  winScore: _winScore,
                );
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: _isComplete == true || _scoreCheck == false
                          ? null
                          : () {
                              FunctionHelper.checkWinner(
                                ref: ref,
                                context: context,
                                lowScore: gameData.match[_index].lowScore,
                                matchId: matchId,
                                matchIndex: _index,
                              );
                            },
                      child: Icon(Icons.done),
                      style: ElevatedButton.styleFrom(
                        onPrimary: Colors.white,
                      ),
                    ),
                    // Game Name
                    Text('$_gameName',
                        style: Theme.of(context).textTheme.headline3),

                    Spacer(),
                    // Play again button
                    TextButton(
                      onPressed: _isComplete == false
                          ? null
                          : () {
                              PopupDialogWidgets.copyMatchDialog(
                                  ref, context, matchId);
                              // gameData.copyMatch(id: matchId);
                            },
                      child: Icon(Icons.replay),
                      style: ElevatedButton.styleFrom(
                        onPrimary: Colors.white,
                      ),
                    ),
                    // Low Score/High Score
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
