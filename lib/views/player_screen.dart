import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/player_controller.dart';
import 'player_list.dart';
import './settings.dart';

enum FilterOptions {
  Players,
  Teams,
  Games,
  Settings,
  AddPlayer,
  AddTeam,
  AddGame
}

class PlayersScreen extends StatelessWidget {
  static const routeName = 'players_screen';
  // final PlayerController controller = Get.find<PlayerController>();
  final PlayerController controller = Get.put(PlayerController());

  void selectSettings(BuildContext ctx, value) {
    if (value == FilterOptions.Settings) {
      Navigator.of(ctx).pushNamed(Settings.routeName);
    } else if (value == FilterOptions.Players) {
      Navigator.of(ctx).pushNamed(PlayersScreen.routeName);
    } else if (value == FilterOptions.AddPlayer) {
      //  Provider.of<PlayerProvider>(ctx, listen: false).addPlayer(1);
      controller.addPlayer();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Players",
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
                  leading: Icon(Icons.person_add),
                  title: Text(
                    "Add Player",
                  ),
                ),
                value: FilterOptions.AddPlayer,
              )
            ],
          ),
        ],
      ),
      body: PlayerList(),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white70,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        child: Icon(Icons.add),
        onPressed: () {
          // Provider.of<PlayerProvider>(context, listen: false).addPlayer(1);
          controller.addPlayer();
        },
      ),
    );
  }
}
