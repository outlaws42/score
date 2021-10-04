import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:score/controllers/providers.dart';
import '../helpers/custom_widgets/page_widgets.dart';
import 'player_tile.dart';
import './match.dart';

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

class MatchCurrentScreen extends StatelessWidget {
  final matchId = Get.arguments;
  // int matchId = ;
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
        title: Consumer(builder: (context, watch, child) {
          final _matches = watch(matchProvider).match;
          var _index = _matches.indexWhere((match) => match.id == matchId[0]);
          if (_index == -1) {
            // Get rid of error when it is the only item until db can assing id
            _index = 0;
          }
          final _matchName = _matches[_index].matchName;
          return _matchName != ""
              ? Text(
                  "$_matchName",
                  style: Theme.of(context).textTheme.headline3,
                )
              : Text(
                  "Player Match",
                  style: Theme.of(context).textTheme.headline3,
                );
        }),
        actions: [
          PageWidgets().iconButtonBar(
            context: context,
            pageLink: "/match",
            icon: Icon(Icons.list_alt),
          ),
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              print(selectedValue);
              selectSettings(context, selectedValue);
            },
            icon: Icon(Icons.more_vert),
            // onSelected: (Filter){},
            itemBuilder: (_) => [
              PopupMenuItem(
                  child: ListTile(
                    horizontalTitleGap: -10,
                    leading: Icon(Icons.person),
                    title: Text(
                      "Matches",
                    ),
                  ),
                  value: FilterOptions.Matches),
              PopupMenuItem(
                  child: ListTile(
                    horizontalTitleGap: -10,
                    leading: Icon(Icons.person),
                    title: Text(
                      "Players",
                    ),
                  ),
                  value: FilterOptions.Players),
              PopupMenuItem(
                child: ListTile(
                  horizontalTitleGap: -10,
                  leading: Icon(Icons.games),
                  title: Text(
                    "Games",
                  ),
                ),
                value: FilterOptions.Games,
              ),
              PopupMenuItem(
                child: ListTile(
                  horizontalTitleGap: -10,
                  leading: Icon(Icons.people),
                  title: Text(
                    "Teams",
                  ),
                ),
                value: FilterOptions.Teams,
              ),
              PopupMenuItem(
                child: ListTile(
                  horizontalTitleGap: -10,
                  leading: Icon(Icons.settings),
                  title: Text(
                    "Settings",
                  ),
                ),
                value: FilterOptions.Settings,
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Match(
              matchId: matchId[0],
            ),
            PlayerTile(
              player: "player1",
              matchId: matchId[0],
            ),
            PlayerTile(
              player: "player2",
              matchId: matchId[0],
            ),
          ],
        ),
      ),
      // }),
    );
  }
}
