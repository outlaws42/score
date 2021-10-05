import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:get/get.dart';
import '../controllers/providers.dart';
import '../helpers/custom_widgets/page_widgets.dart';
import '../helpers/custom_widgets/menu_widgets.dart';
// import '../controllers/player_provider.dart';
// import '../controllers/player_controller.dart';
// import './player_form.dart';
import './player_list.dart';


// enum FilterOptions {
//   Home,
//   AddPlayer,
// }

class PlayersScreen extends StatelessWidget {
  // static const routeName = 'players_screen';
  // final PlayerController controller = Get.find<PlayerController>();
  // final PlayerController controller = Get.put(PlayerController());

  // void selectSettings(BuildContext ctx, value) {
  //   if (value == FilterOptions.Home) {
  //      Get.toNamed("/", arguments: ["player_screen"]);
  //   }  else if (value == FilterOptions.AddPlayer) {
  //     // Provider.of<PlayerProvider>(ctx, listen: false).addPlayer(1);
  //     // ctx.read(playerProvider).addPlayer();
  //     Get.to(()=> PlayerForm());
  //     // controller.addPlayer();
  //   }
  // }

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
          MenuWidgets.mainMenu(
              context: context,
              screenArgument: "player_screen"
            ),
          // PopupMenuButton(
          //   onSelected: (FilterOptions selectedValue) {
          //     print(selectedValue);
          //     selectSettings(context, selectedValue);
          //   },
          //   icon: Icon(Icons.more_vert),
          //   iconSize: 30,
          //   // onSelected: (Filter){},
          //   itemBuilder: (_) => [
          //     PopupMenuItem(
          //       child: ListTile(
          //         horizontalTitleGap: -10,
          //         leading: Icon(Icons.home),
          //         title: Text(
          //           "Home",
          //         ),
          //       ),
          //       value: FilterOptions.Home,
          //     ),
          //     PopupMenuItem(
          //       child: ListTile(
          //         horizontalTitleGap: -10,
          //         leading: Icon(Icons.person_add),
          //         title: Text(
          //           "Add Player",
          //         ),
          //       ),
          //       value: FilterOptions.AddPlayer,
          //     )
          //   ],
          // ),
        ],
      ),
      body: PlayerList(),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white70,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        child: Icon(Icons.add),
        onPressed: () {
          // Provider.of<PlayerProvider>(context, listen: false).addPlayer(1);
          context.read(playerProvider).addPlayer();
          context.read(playerProvider).fetchPlayer();
          // controller.addPlayer();
        },
      ),
    );
  }
}
