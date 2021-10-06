import 'package:flutter/material.dart';
import './match_list.dart';
import '../helpers/custom_widgets/page_widgets.dart';
import '../helpers/custom_widgets/menu_widgets.dart';

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
            PageWidgets().iconButtonBar(
              context: context,
              pageLink: "/match_form",
              icon: Icon(Icons.post_add),
            ),
            PopupMenuButton(
              iconSize: 30,
              icon: Icon(Icons.menu),
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
                  ],
              onSelected: (value) {
                print(value);
                MenuWidgets.menuSelect(context, value, "match_screen");
              })
          ],
        ),
        body: MatchList()
        );
  }
}
