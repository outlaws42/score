import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  final arguments = Get.arguments;
  void selectSettings(BuildContext ctx, value) {
    if (value == FilterOptions.Players) {
      Get.toNamed("/players", arguments: ["main_screen", "player"]);
    } else if (value == FilterOptions.Games) {
      Get.toNamed("/games");
    } else if (value == FilterOptions.Teams) {
      Get.toNamed("/teams");
    } else if (value == FilterOptions.Settings) {
      Get.toNamed("/settings");
    } else if (value == FilterOptions.Matches) {
      Get.toNamed("/match");
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
        actions: [
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
      body:  SingleChildScrollView(
        child: Column(
            children: [
              Match(matchId: arguments[0],),
              PlayerTile(
                player: "player1",
                matchId: arguments[0],
              ),
              PlayerTile(
                player: "player2",
                matchId: arguments[0],
              ),
            ],
          ),
      ),
      // }),
    );
  }
}
