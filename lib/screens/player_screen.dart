import 'package:flutter/material.dart';
import 'package:score/providers/player_provider.dart';
import '../widgets/player_body.dart';
import 'package:provider/provider.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// import '../widgets/main_body.dart';
// import '../providers/webview_provider.dart';
import '../screens/settings.dart';

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
  
  void selectSettings(BuildContext ctx, value) {

    if (value == FilterOptions.Settings) {
      Navigator.of(ctx).pushNamed(Settings.routeName);

    } else if (value == FilterOptions.Players) {
      Navigator.of(ctx).pushNamed(PlayersScreen.routeName);

    }
     else if (value == FilterOptions.AddPlayer) {
      Provider.of<PlayerProvider>(ctx, listen: false).addPlayer(1);
    }
    
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: Text("Players", style: Theme.of(context).textTheme.headline3,),
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
                  child: Text("Add Player"), value: FilterOptions.AddPlayer)
            ],
          ),
        ],
      ),
      body: PlayerBody(),
    );
  }
}
