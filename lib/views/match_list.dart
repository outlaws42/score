import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import '../helpers/custom_widgets/page_widgets.dart';
import '../controllers/providers.dart';
import '../helpers/function_helpers.dart';

class MatchList extends ConsumerWidget {
  // showBottomSheet(game, description, endscore, id) {
  //   Get.bottomSheet(
  //     Container(
  //       color: Colors.white,
  //       child: Padding(
  //         padding: const EdgeInsets.all(30.0),
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //           children: [
  //             Text("$id"),
  //             Text("$game"),
  //             Text("$description"),
  //             Text("$endscore"),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget _listItem(index, match, context) {
    final _id = match[index].id;
    final _gameName = match[index].gameName;
    final _player1Name = match[index].player1Name;
    final _player2Name = match[index].player2Name;
    final _endScore = match[index].winScore;
    final _freePlay = match[index].freePlay;
    final _winner = match[index].winner;
    final _isComplete = match[index].isComplete;
    final _date = FunctionHelper().convertToDate(
      dateTimeUtcInt: match[index].dateTime,
    );

    bool _player1 = false;
    bool _player2 = false;

    if (_isComplete == true && _player1Name == _winner) {
      _player1 = true;
    } else if (_isComplete == true && _player2Name == _winner) {
      _player2 = true;
    }
    print(_player2Name);
    return Container(
      padding: const EdgeInsets.all(2),
      child: Card(
        elevation: 3,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: ListTile(
          title: Text(
            '$_gameName',
            style: Theme.of(context).textTheme.headline4,
          ),
          subtitle: _player1 == false && _player2 == false
              ? Text(
                  '$_player1Name vs $_player2Name',
                  style: Theme.of(context).textTheme.subtitle1,
                )
              : _player1 == true
                  ? Text(
                      '$_player1Name (Winner) vs $_player2Name',
                      style: Theme.of(context).textTheme.subtitle1,
                    )
                  : Text(
                      '$_player1Name vs $_player2Name (Winner)',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
                _freePlay == true
                    ? 
                        PageWidgets().circleContainer(
                            context: context,
                            content: "FP",
                          )
                    : PageWidgets().circleContainer(
                        context: context,
                        content: _endScore.toString(),
                      ),
                
              Text(
                '$_date',
                style: Theme.of(context).textTheme.subtitle1,
              )
            ],
          ),
          onTap: () {
            Get.offAllNamed("/match_current", arguments: [
              _id,
            ]);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final _match = watch(matchProvider).match;
    return _match.length == 0
        ? PageWidgets().noData(
            context: context,
            pageName: 'match',
            pageLink: '/match_form',
          )
        : ListView.builder(
            itemCount: _match.length,
            itemBuilder: (ctx, index) {
              if (index == 0) {
                return Column(
                  children: [
                    PageWidgets().header(
                      context: context,
                      column1: 'Match',
                      column2: 'Winning Score'
                      ),
                    _listItem(index, _match, context)
                  ],
                );
              } else
                return _listItem(index, _match, context);
            },
          );
    // );
  }
}
