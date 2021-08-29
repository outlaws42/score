import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:score/widgets/drop_down_players.dart';
import '../providers/player_provider.dart';
import '../providers/game_provider.dart';
import '../widgets/game_body.dart';
import '../screens/settings.dart';
import '../screens/player_screen.dart';
import '../screens/game_screen.dart';

enum FilterOptions {
  Players,
  Teams,
  Games,
  Settings,
  AddPlayer,
  AddTeam,
  AddGame
  
}

class TeamScreen extends StatelessWidget {
  static const routeName = 'team_screen';
  
  void selectSettings(BuildContext ctx, value) {

    if (value == FilterOptions.Settings) {
      Navigator.of(ctx).pushNamed(Settings.routeName);

    } else if (value == FilterOptions.Players) {
      Navigator.of(ctx).pushNamed(PlayersScreen.routeName);

    }
     else if (value == FilterOptions.AddPlayer) {
      Provider.of<PlayerProvider>(ctx, listen: false).addPlayer(1);

    } else if (value == FilterOptions.AddGame) {
      Provider.of<GameProvider>(ctx, listen: false).addGame();
    }
    
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: Text("Teams", style: Theme.of(context).textTheme.headline3,),
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
                  child: Text("Settings"), value: FilterOptions.Settings),
              PopupMenuItem(
                  child: Text("Players"), value: FilterOptions.Players),
              PopupMenuItem(
                  child: Text("Add Player"), value: FilterOptions.AddPlayer),
              PopupMenuItem(
                  child: Text("Add Game"), value: FilterOptions.AddGame)
            ],
          ),
        ],
      ),
      body: DropdownPlayers(),
    );
  }
}
