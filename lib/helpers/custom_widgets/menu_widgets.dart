import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../../controllers/providers.dart';

enum FilterOptions {
  Players,
  Teams,
  Games,
  Matches,
  Settings,
  AddPlayer,
  AddTeam,
  AddGame,
  AddMatch,
}

class MenuWidgets {
  static menuPage(
    BuildContext ctx,
    value,
    String screen,
  ) {
    if (value == FilterOptions.Players) {
      Get.toNamed("/players", arguments: [screen, "player"]);
    } else if (value == FilterOptions.Games) {
      Get.toNamed("/games", arguments: [screen,"game"]);
    } else if (value == FilterOptions.Teams) {
      Get.toNamed("/teams", arguments: [screen, "team"]);
    } else if (value == FilterOptions.Settings) {
      Get.toNamed("/settings", arguments: [screen, "setting"]);
    } else if (value == FilterOptions.Matches) {
      Get.toNamed("/match", arguments: [screen,"setting"]);
    }
  }

  static Widget mainMenu({
    required BuildContext context,
    String screenArgument = "match_screen",
  }) {
    return PopupMenuButton(
      onSelected: (
        FilterOptions selectedValue,
      ) {
        print(selectedValue);
        MenuWidgets.menuPage(
          context,
          selectedValue,
          screenArgument,
        );
      },
      iconSize: 30,
      icon: Icon(Icons.menu),
      // onSelected: (Filter){},
      itemBuilder: (_) => [
        PopupMenuItem(
          child: ListTile(
            horizontalTitleGap: -10,
            leading: Icon(Icons.list_alt),
            title: Text(
              "Matches",
            ),
          ),
          value: FilterOptions.Matches,
        ),
        PopupMenuItem(
            child: ListTile(
              horizontalTitleGap: -10,
              leading: Icon(Icons.person),
              title: Text(
                "Players",
              ),
            ),
            value: FilterOptions.Players),
        PopupMenuItem(
          child: ListTile(
            horizontalTitleGap: -10,
            leading: Icon(Icons.games),
            title: Text(
              "Games",
            ),
          ),
          value: FilterOptions.Games,
        ),
        // PopupMenuItem(
        //   child: ListTile(
        //     horizontalTitleGap: -10,
        //     leading: Icon(Icons.people),
        //     title: Text(
        //       "Teams",
        //     ),
        //   ),
        //   value: FilterOptions.Teams,
        // ),
        
        PopupMenuItem(
          child: ListTile(
            horizontalTitleGap: -10,
            leading: Icon(Icons.settings),
            title: Text(
              "Settings",
            ),
          ),
          value: FilterOptions.Settings,
        ),
        
      ],
    );
  }
}
