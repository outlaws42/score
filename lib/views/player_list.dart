import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:flutter/widgets.dart';
import 'package:score/controllers/player_provider.dart';
import '../models/match_model.dart';
import '../models/player_model.dart';
import '../controllers/providers.dart';
import '../helpers/function_helpers.dart';
import '../helpers/custom_widgets/page_widgets.dart';
import './player_form.dart';

class PlayerList extends ConsumerWidget {
  final List _selectedPlayers = [1, 2, 3, 4];
  showBottomSheet({
    required int playerId,
    required List<MatchModel> matchList,
  }) {
    var _wins = matchList.where((win) => win.winnerId == playerId).toList();

    Get.bottomSheet(
      Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: _wins.length == 0
              ? Text(
                  "No Wins Yet, Please keep trying",
                  // style: Theme.of(context).textTheme.head,
                )
              : ListView.builder(
                  itemCount: _wins.length,
                  itemBuilder: (context, index) {
                    final _date = FunctionHelper().convertToDate(
                      dateTimeUtcInt: _wins[index].dateTime,
                    );
                    return Container(
                        child: Card(
                      elevation: 3,
                      color: Theme.of(context).scaffoldBackgroundColor,
                      child: ListTile(
                        // leading: ,
                        title: Text(
                          "${_wins[index].matchName} ${_wins[index].gameName}",
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                        subtitle: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "${_wins[index].player1Name}:  ${_wins[index].player1Score}",
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            Text(
                              "${_wins[index].player2Name}: ${_wins[index].player2Score}",
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          ],
                        ),
                        trailing: Text('$_date'),
                      ),
                    ));
                  }),
        ),
      ),
    );
  }

  Widget _listItem({
    required BuildContext context,
    required int index,
    required List<PlayerModel> player,
    required List<MatchModel> matchList,
    required PlayerProvider playerProv,
  }) {
    List _selectedItems = [];
    List _oLPSelectedItems = [];
    List arguments = Get.arguments;
    final _name = player[index].name;
    final _wins = player[index].wins;
    final _id = player[index].id;
    bool _isSelected = player[index].isSelected;
    // final _date = FunctionHelper().convertToDate(
    //   dateTimeUtcInt: player[index].dateTime,
    // );
    // print(arguments);
    return Container(
      padding: const EdgeInsets.all(2),
      child: Card(
        elevation: 3,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: ListTile(
          onLongPress: () {
            _oLPSelectedItems.add(_id);
            // print(_oLPSelectedItems);
            context.read(playerProvider).updateSelected(
                  playerId: _id,
                  isSelected: _isSelected,
                );
            // print("_isSelected: $_isSelected");
          },
          onTap: () async {
            if (arguments[0] == 'player_tile' || arguments[0] == 'form') {
              _selectedItems = [_name, _id];
              // print(_selectedItems);
              Get.back(result: _selectedItems);
            } else {
              // print(arguments[0]);
              await showBottomSheet(
                playerId: _id,
                matchList: matchList,
              );
            }
          },
          title: Text(
            '$_name $_isSelected',
            style: Theme.of(context).textTheme.headline6,
          ),
          trailing: Container(
            alignment: Alignment.center,
            height: 30,
            width: 30,
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).appBarTheme.backgroundColor,
                boxShadow: [
                  BoxShadow(color: Colors.black26, blurRadius: 8.0),
                ]),
            child: Text(
              '${_wins.toString()}',
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
        ),
      ),
    );
  }

  Widget header(context) {
    return Card(
      elevation: 6,
      color: Theme.of(context).appBarTheme.backgroundColor,
      child: ListTile(
        title: Text('Name', style: Theme.of(context).textTheme.headline3),
        trailing: Text('Wins', style: Theme.of(context).textTheme.headline3),
      ),
    );
  }

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    List args = Get.arguments;

    // _selectedPlayers.add(args[1]);
    // print("This is the _selectedPlayers $_selectedPlayers");
    final _player = watch(playerProvider);
    final _matchList = watch(matchProvider).match;
    // print(_player.player.length);
    var _filterPlayer = args[0] == "form"
        ? _player.player.where((win) => win.id != int.parse(args[1])).toList()
        : _player.player;
    // var _filterPlayer = args[0] =="form" ?_player
    //     .where((win) => _selectedPlayers.any((field)=> field != win.id))
    //     .toList(): _player;
    return _player.player.length == 0
        ? PageWidgets().noData(
            context: context,
            pageName: 'player',
            pageLink: PlayerForm(),
          )
        : ListView.builder(
            itemCount: args[0] == "form"
                ? _filterPlayer.length
                : _player.player.length,
            itemBuilder: (contex, index) {
              if (index == 0) {
                return Column(
                  children: [
                    header(context),
                    _listItem(
                      context: context,
                      index: index,
                      player:
                          args[0] == "form" ? _filterPlayer : _player.player,
                      matchList: _matchList,
                      playerProv: _player,
                    )
                  ],
                );
              } else
                return _listItem(
                  context: context,
                  index: index,
                  player: args[0] == "form" ? _filterPlayer : _player.player,
                  matchList: _matchList,
                  playerProv: _player,
                );
            },
          );
    // }

    // );
  }
}
