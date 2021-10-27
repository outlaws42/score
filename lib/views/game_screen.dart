import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../helpers.dart';
import './game_list.dart';

class GameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Games",
          style: Theme.of(context).textTheme.headline3,
        ),
        actions: [
          PageWidgets().iconButtonBarDocs(
            context: context,
            data: "assets/help_game.md",
            icon: Icon(MdiIcons.help),
            iconSize: 25,
          ),
          PageWidgets().iconButtonBar(
            context: context,
            pageLink: "/game_form",
            icon: Icon(Icons.add_box),
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
                      menuTitle: "Players",
                      icon: Icon(Icons.person),
                      value: 2,
                    ),
                    MenuWidgets.menuItem(
                      context: context,
                      menuTitle: "Settings",
                      icon: Icon(Icons.settings),
                      value: 10,
                    ),
                  ],
              onSelected: (value) {
                MenuWidgets.menuSelect(
                  context,
                  value,
                  "game_screen",
                );
              })
        ],
      ),
      body: GameList(),
    );
  }
}
