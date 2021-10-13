import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/providers.dart';
// import '../helpers/custom_widgets/page_widgets.dart';
// import '../helpers/custom_widgets/menu_widgets.dart';
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
          PageWidgets().iconButtonBar(
            context: context,
            pageLink: "/game_form",
            icon: Icon(Icons.add_box),
          ),
          IconButton(
                            onPressed: () {
                              context.read(gameProvider).export(
                                  );

                              print("Pressed Edit");
                            },
                            icon: Icon(Icons.edit),
                            iconSize: 30,
                            color:
                                Theme.of(context).appBarTheme.foregroundColor,
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
                print(value);
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
