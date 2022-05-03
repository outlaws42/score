import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:score/controllers/providers.dart';
import 'player_tile_update.dart';
import './match.dart';
import '../helpers.dart';

enum FilterOptions {
  Players,
  Teams,
  Games,
  Settings,
  AddPlayer,
  AddTeam,
  AddGame,
  Matches
}

class MatchCurrentScreenList extends StatelessWidget {
  final matchId = Get.arguments;
  void selectSettings(BuildContext ctx, value) {
    if (value == FilterOptions.Players) {
      Get.toNamed("/players", arguments: ["match_current_screen", "players"]);
    } else if (value == FilterOptions.Games) {
      Get.toNamed("/games", arguments: ["match_current_screen", "games"]);
    } else if (value == FilterOptions.Teams) {
      Get.toNamed("/teams", arguments: ["match_current_screen", "teams"]);
    } else if (value == FilterOptions.Settings) {
      Get.toNamed("/settings", arguments: ["match_current_screen", "settings"]);
    } else if (value == FilterOptions.Matches) {
      Get.toNamed("/match", arguments: ["match_current_screen", "matches"]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Player Match",
          style: Theme.of(context).textTheme.headline3,
        ),
        // }),
        actions: [
          PageWidgets().iconButtonBarDocs(
            context: context,
            data: "assets/help_current_match.md",
            icon: Icon(MdiIcons.help),
            iconSize: 25,
          ),
          PageWidgets().iconButtonBar(
            context: context,
            pageLink: "/match",
            icon: Icon(Icons.list_alt),
          ),
          PopupMenuButton(
              iconSize: 30,
              icon: Icon(Icons.menu),
              itemBuilder: (BuildContext context) => <PopupMenuItem>[
                    MenuWidgets.menuItem(
                      context: context,
                      menuTitle: "Matches",
                      icon: Icon(Icons.list_alt),
                      value: 1,
                    ),
                    MenuWidgets.menuItem(
                      context: context,
                      menuTitle: "Players",
                      icon: Icon(Icons.person),
                      value: 2,
                    ),
                    MenuWidgets.menuItem(
                      context: context,
                      menuTitle: "Games",
                      icon: Icon(Icons.games),
                      value: 3,
                    ),
                    MenuWidgets.menuItem(
                      context: context,
                      menuTitle: "Settings",
                      icon: Icon(Icons.settings),
                      value: 10,
                    ),
                  ],
              onSelected: (value) {
                MenuWidgets.menuSelect(
                  context,
                  value,
                  "current_match_screen",
                );
              })
        ],
      ),
      body: Consumer(builder: (context, watch, child) {
        final _matches = watch(matchProvider).match;
        var _index = _matches.indexWhere((match) => match.id == matchId[0]);
        if (_index == -1) {
          // Get rid of error when it is the only item until db can assing id
          _index = 0;
        }

        final _matchPlayersId = _matches[_index].players;
        final _matchPlayersName = _matches[_index].players;
        final _matchPlayersScore = _matches[_index].players;
        final _matchPlayersColor = _matches[_index].players;
        // print("${_matchPlayersName[0]}, ${_matchPlayersId[0]},"
        // " ${_matchPlayersScore[0]}, ${_matchPlayersColor[0]}");

        List _playerList = [];
        for (var item in _matchPlayersName) {
          if (item != null) {
            _playerList.add(item);
          }
        }
        print('_playerList Length (match_current_screen_list): ${_playerList.length}');
        return Column(
          children: [
            Match(
              matchId: matchId[0],
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _playerList.length,
                itemBuilder: (ctx, index) {
                  return
                  // ListTile(
                  //   title: Text(
                  //       '_playerList Length (match_current_screen_list): ${_matches[_index].players[index].playerName}'),);
                  PlayerTileUpdate(
                    player: _matches[_index].players[index].playerName,
                    matchId: matchId[0],
                    playerIndex: index,
                    playerScore: _matches[_index].players[index].score,
                  );
                },
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
              ),
            ),
            // PlayerTile(
            //   player: "player1",
            //   matchId: matchId[0],
            // ),
            // PlayerTile(
            //   player: "player2",
            //   matchId: matchId[0],
            // ),
          ],
        );
      }),
    );
  }
}
