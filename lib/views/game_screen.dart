import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/game_controller.dart';
import './game_list.dart';
import './settings.dart';
import './player_screen.dart';

enum FilterOptions {
  Players,
  Teams,
  Games,
  Settings,
  AddPlayer,
  AddTeam,
  AddGame
}

class GameScreen extends StatelessWidget {
  static const routeName = 'game_screen';
  final GameController controller = Get.put(GameController());

  void selectSettings(BuildContext ctx, value) {
    if (value == FilterOptions.Settings) {
      Navigator.of(ctx).pushNamed(Settings.routeName);
    } else if (value == FilterOptions.Players) {
      Navigator.of(ctx).pushNamed(PlayersScreen.routeName);
    } else if (value == FilterOptions.AddGame) {
      // Provider.of<GameProvider>(ctx, listen: false).addGame();
      controller.addGame();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Games",
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
                  leading: Icon(Icons.games),
                  title: Text(
                    "Add Game",
                  ),
                ),
                value: FilterOptions.AddPlayer,
              )
            ],
          ),
        ],
      ),
      body: GameList(),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white70,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        child: Icon(Icons.add),
        onPressed: () {
          // Provider.of<PlayerProvider>(context, listen: false).addPlayer(1);
          controller.addGame();
        },
      ),
    );
  }
}
