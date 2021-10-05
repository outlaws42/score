import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:get/get.dart';
import '../controllers/providers.dart';
import '../helpers/custom_widgets/page_widgets.dart';
import '../helpers/custom_widgets/menu_widgets.dart';
// import './game_form.dart';
import './game_list.dart';

// enum FilterOptions {
//   Home,
//   AddGame
// }


class GameScreen extends StatelessWidget {
  // static const routeName = 'game_screen';
  // final GameController controller = Get.put(GameController());

  // void selectSettings(BuildContext ctx, value) {
  //   if (value == FilterOptions.Home) {
  //      Get.toNamed("/", arguments: ["game_screen"]);
  //   }  else if (value == FilterOptions.AddGame) {
  //     Get.to(()=> GameForm());
  //     // Provider.of<GameProvider>(ctx, listen: false).addGame();
  //     // ctx.read(gameProvider).addGame();
  //   }
  // }

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
          MenuWidgets.mainMenu(
              context: context,
              screenArgument: "game_screen"
            ),
          // PopupMenuButton(
          //  onSelected: (FilterOptions selectedValue) {
          //     print(selectedValue);
          //     selectSettings(context, selectedValue);
          //   },
          //   icon: Icon(Icons.more_vert),
          //   // onSelected: (Filter){},
          //   iconSize: 30,
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
          //         leading: Icon(Icons.games),
          //         title: Text(
          //           "Add Game",
          //         ),
          //       ),
          //       value: FilterOptions.AddGame,
          //     )
          //   ],
          // ),
        ],
      ),
      body: GameList(),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white70,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        child: Icon(Icons.add),
        onPressed: () {
          // Provider.of<PlayerProvider>(context, listen: false).addPlayer(1);
          context.read(gameProvider).addGame();
          context.read(gameProvider).fetchGame();
          // controller.addGame();
        },
      ),
    );
  }
}
