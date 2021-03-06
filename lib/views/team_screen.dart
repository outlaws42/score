import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './player_list.dart';


enum FilterOptions {
  Home,
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

    if (value == FilterOptions.Home) {
      Get.toNamed("/", arguments: ["team_screen"]);
    }  else if (value == FilterOptions.AddTeam) {
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
              selectSettings(context, selectedValue);
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: ListTile(
                  horizontalTitleGap: -10,
                  leading: Icon(Icons.home),
                  title: Text(
                    "Home",
                  ),
                ),
                value: FilterOptions.Home,
              ),

              PopupMenuItem(
                child: ListTile(
                  horizontalTitleGap: -10,
                  leading: Icon(Icons.people),
                  title: Text(
                    "Add Teams",
                  ),
                ),
                value: FilterOptions.AddTeam,
              )
            ],
          ),
        ],
      ),
      body: PlayerList(),
    );
  }
}
