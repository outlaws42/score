import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/player_provider.dart';
import '../providers/settings_provider.dart';
import '../providers/game_provider.dart';
import './player_screen.dart';
import './game_screen.dart';
import './team_screen.dart';
import './settings.dart';
import '../widgets/main_body.dart';
import '../widgets/drop_down_players.dart';

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
      Navigator.of(ctx).pushNamed(PlayersScreen.routeName);

    }else if (value == FilterOptions.Games) {
      Navigator.of(ctx).pushNamed(GameScreen.routeName);

    } else if (value == FilterOptions.Teams) {
      Navigator.of(ctx).pushNamed(TeamScreen.routeName);

    } else if (value == FilterOptions.Settings) {
      Navigator.of(ctx).pushNamed(Settings.routeName);

    } else if (value == FilterOptions.AddPlayer) {
      Provider.of<PlayerProvider>(ctx, listen: false).addPlayer(1);
    }else if (value == FilterOptions.AddGame) {
      Provider.of<GameProvider>(ctx, listen: false).addGame();
    }
  }

  @override
  Widget build(BuildContext context) {
    final _appName = Provider.of<SettingsProvider>(context).getAppName();
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder(
          future: _appName,
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) =>
              Text(
            snapshot.hasData ? snapshot.data! : "Loading ...",
            style: Theme.of(context).textTheme.headline3,
          ),
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
                  child: Text("Players"), value: FilterOptions.Players),
              PopupMenuItem(
                  child: Text("Games"), value: FilterOptions.Games),
              PopupMenuItem(
                  child: Text("Teams"), value: FilterOptions.Teams),
              PopupMenuItem(
                  child: Text("Settings"), value: FilterOptions.Settings),
              PopupMenuItem(
                  child: Text("Add Player"), value: FilterOptions.AddPlayer),
              PopupMenuItem(
                  child: Text("Add Game"), value: FilterOptions.AddGame)
            ],
          ),
        ],
      ),
      body: MainBody(),
    );
  }
}