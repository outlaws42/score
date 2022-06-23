import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import './match_list.dart';
import '../helpers.dart';

class MatchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Matches",
            style: Theme.of(context).textTheme.headline3,
          ),
          actions: [
            PageWidgets().iconButtonBarDocs(
            context: context,
            data: "assets/help_match.md",
            icon: Icon(MdiIcons.help),
            iconSize: 25,
          ),
            PageWidgets().iconButtonBar(
              context: context,
              pageLink: "/match_form",
              icon: Icon(Icons.post_add),
            ),
            PopupMenuButton(
                iconSize: 30,
                icon: Icon(Icons.menu),
                color: Theme.of(context).appBarTheme.foregroundColor,
                itemBuilder: (BuildContext context) => <PopupMenuItem>[
                      MenuWidgets.menuItem(
                        context: context,
                        menuTitle: "Players",
                        icon: Icon(Icons.person),
                        value: 2,
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
                      MenuWidgets.menuItem(
                        context: context,
                        menuTitle: "Logout",
                        icon: Icon(Icons.logout),
                        value: 15,
                      ),
                    ],
                onSelected: (value) {
                  MenuWidgets.menuSelect(
                    context,
                    value,
                    "match_screen",
                  );
                })
          ],
        ),
        body: MatchList());
  }
}
