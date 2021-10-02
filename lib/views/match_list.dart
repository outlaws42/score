import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import '../helpers/custom_widgets/page_widgets.dart';
import '../controllers/providers.dart';
import '../helpers/function_helpers.dart';
import './match_form.dart';

// import 'package:provider/provider.dart';
// import 'package:get/get.dart';
// import '../controllers/game_provider.dart';
// import '../controllers/game_provider.dart';

// final gameProvider = ChangeNotifierProvider<GameProvider>((ref) => GameProvider());

class MatchList extends ConsumerWidget {
  showBottomSheet(game, description, endscore, id) {
    Get.bottomSheet(
      Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("$id"),
              Text("$game"),
              Text("$description"),
              Text("$endscore"),
            ],
          ),
        ),
      ),
    );
  }

  

  Widget _listItem(index, match, context) {
    // List _selectedItems = [];
    // var arguments = Get.arguments;
    final _id = match[index].id;
    final _gameName = match[index].gameName;
    // final _matchName = game.match[index].matchName;
    final _player1Name = match[index].player1Name;
    final _player2Name = match[index].player2Name;
    // final _player1Id = game.match[index].player1Id;
    // final _player2Id = game.match[index].player2Id;
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
          leading: Text(
            '$_id',
            style: Theme.of(context).textTheme.headline6,
          ),
          title: Text(
            '$_gameName',
            style: Theme.of(context).textTheme.headline6,
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
                  ? Text("Free Play")
                  : Container(
                      alignment: Alignment.center,
                      height: 30,
                      width: 30,
                      margin: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).appBarTheme.backgroundColor,
                          boxShadow: [
                            BoxShadow(color: Colors.black26, blurRadius: 2.0),
                          ]),
                      child: Text(
                        '$_endScore',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
              Text(
                '$_date',
                style: Theme.of(context).textTheme.subtitle1,
              )
            ],
          ),
          onTap: () {
            // if (arguments[0] == 'match') {
            //   _selectedItems = [ _matchName, _endScore,_id];
            //       // play.player[index].firstName; // assign first name
            //   print(_selectedItems);
            //   Get.back(result: _selectedItems);
            // } else {
            // print(arguments[0]);
            // showBottomSheet(
            //   _gameName,
            //   _player1Name,
            //   _player2Name,
            //   _id,
            // );
            Get.offAllNamed("/match_current", arguments: [
              _id,
              // _player1Name,
              // _player2Name
            ]);
            // }
          },
        ),
      ),
    );
  }

  Widget header(context) {
    return Card(
      elevation: 6,
      color: Theme.of(context).appBarTheme.backgroundColor,
      child: ListTile(
        // leading: Container(
        //   width: 30,
        //   alignment: Alignment.center,
        //   child: Text('Id', style: Theme.of(context).textTheme.headline5),
        // ),
        title: Text('Matches', style: Theme.of(context).textTheme.headline3),
        trailing:
            Text('Wining Score', style: Theme.of(context).textTheme.headline3),
      ),
    );
  }

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    //final firstName = Provider.of<PlayerProvider>(context, listen: false).fetchPlayer();
    final _match = watch(matchProvider).match;
    return _match.length == 0
        ? PageWidgets().noData(
            context: context,
            pageName: 'match',
            pageLink: MatchForm(),
          )
        : ListView.builder(
            // separatorBuilder: (context, index) => Divider(
            //       height: 0,
            //       thickness: 1,
            //       indent: 0,
            //       endIndent: 0,
            //     ),
            itemCount: _match.length,
            itemBuilder: (ctx, index) {
              if (index == 0) {
                return Column(
                  children: [
                    header(context),
                    // Divider(
                    //   height: 0,
                    //   thickness: 4,
                    //   indent: 0,
                    //   endIndent: 0,
                    // ),
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
