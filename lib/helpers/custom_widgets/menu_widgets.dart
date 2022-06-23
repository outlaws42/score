import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:score/helpers.dart';


class MenuWidgets {

  static menuSelect(
    BuildContext ctx,
    value,
    String screen,
  ) {
    if (value == 1) {
      Get.toNamed("/match", arguments: [screen, "matches"]);
    } else if (value == 2) {
      Get.toNamed("/players", arguments: [screen,"players"]);
    } else if (value == 3) {
      Get.toNamed("/games", arguments: [screen, "game"]);
    } else if (value == 4) {
      Get.toNamed("/teams", arguments: [screen, "team"]);
    } else if (value == 10) {
      Get.toNamed("/settings", arguments: [screen,"setting"]);
    }else if (value == 15) {
      FunctionHelper.removePref('userToken');
      Get.toNamed("/auth", arguments: [screen,"logout"]);
    }
  }

  static PopupMenuItem menuItem({
    required BuildContext context,
    required String menuTitle,
    required value,
    bool enable = true, 
    Icon icon = const Icon(Icons.list_alt)
  }) {
    return 
        PopupMenuItem(
          child: ListTile(
            horizontalTitleGap: -10,
            leading: icon,
            title: Text(
              "$menuTitle",
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          value: value,
          enabled: enable,
        );
        
  }
}
