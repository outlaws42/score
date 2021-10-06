import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/providers.dart';
import '../helpers/custom_widgets/page_widgets.dart';
import '../helpers/custom_widgets/menu_widgets.dart';
import './player_list.dart';


class PlayersScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Players",
          style: Theme.of(context).textTheme.headline3,
        ),
        actions: [
          PageWidgets().iconButtonBar(
            context: context,
            pageLink: "/player_form",
            icon: Icon(Icons.person_add),
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
                print(value);
                MenuWidgets.menuSelect(context, value, "player_screen");
              })
        ],
      ),
      body: PlayerList(),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white70,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        child: Icon(Icons.add),
        onPressed: () {
          context.read(playerProvider).addPlayer();
          context.read(playerProvider).fetchPlayer();
        },
      ),
    );
  }
}
