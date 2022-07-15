import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../helpers.dart';
import './game_list.dart';

class GameSelectScreen extends StatelessWidget {
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
            data: "assets/help_game_select.md",
            icon: Icon(MdiIcons.help),
            iconSize: 25,
          ),
          PageWidgets().iconButtonBar(
            context: context,
            pageLink: "/game_form",
            icon: Icon(Icons.add_box),
          ),
        ],
      ),
      body: GameList(),
    );
  }
}
