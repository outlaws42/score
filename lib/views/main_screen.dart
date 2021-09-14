import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './player_tile.dart';
import './match.dart';

enum FilterOptions {
  Players,
  Teams,
  Games,
  Settings,
  AddPlayer,
  AddTeam,
  AddGame
}

class MainScreen extends StatelessWidget {
  void selectSettings(BuildContext ctx, value) {
    if (value == FilterOptions.Players) {
      Get.toNamed("/players", arguments: ["main_screen"]);
    } else if (value == FilterOptions.Games) {
      Get.toNamed("/games");
    } else if (value == FilterOptions.Teams) {
      Get.toNamed("/teams");
    } else if (value == FilterOptions.Settings) {
      Get.toNamed("/settings");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Score",
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
      body: Column(
        children: [
          Match(),
          PlayerTile(),
          PlayerTile(),
        ],
      ),
    );
  }
}
