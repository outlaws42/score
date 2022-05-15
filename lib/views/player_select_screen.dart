import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'player_select_list.dart';
import '../helpers.dart';

class PlayersSelectScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Select Players",
          style: Theme.of(context).textTheme.headline3,
        ),
        actions: [
          PageWidgets().iconButtonBarDocs(
            context: context,
            data: "assets/help_player.md",
            icon: Icon(MdiIcons.help),
            iconSize: 25,
          ),
          PageWidgets().iconButtonBar(
            context: context,
            pageLink: "/player_form",
            icon: Icon(Icons.person_add),
          ),
        ],
      ),
      body: PlayerSelectList(),
    );
  }
}
