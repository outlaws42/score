import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:score/views/player_screen.dart';
import '../controllers/game_provider.dart';
import './game_list.dart';

enum FilterOptions {
  Home,
  AddGame
}
final gameProvider = ChangeNotifierProvider<GameProvider>((ref) => GameProvider());

class GameScreen extends StatelessWidget {
  // static const routeName = 'game_screen';
  // final GameController controller = Get.put(GameController());

  void selectSettings(BuildContext ctx, value) {
    if (value == FilterOptions.Home) {
       Get.toNamed("/", arguments: ["game_screen"]);
    }  else if (value == FilterOptions.AddGame) {
      // Provider.of<GameProvider>(ctx, listen: false).addGame();
      ctx.read(gameProvider).addGame();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Games",
          style: Theme.of(context).textTheme.headline3,
        ),
        actions: [
          PopupMenuButton(
           onSelected: (FilterOptions selectedValue) {
              print(selectedValue);
              selectSettings(context, selectedValue);
            },
            icon: Icon(Icons.more_vert),
            // onSelected: (Filter){},
            itemBuilder: (_) => [
              PopupMenuItem(
                child: ListTile(
                  horizontalTitleGap: -10,
                  leading: Icon(Icons.home),
                  title: Text(
                    "Home",
                  ),
                ),
                value: FilterOptions.Home,
              ),
              PopupMenuItem(
                child: ListTile(
                  horizontalTitleGap: -10,
                  leading: Icon(Icons.games),
                  title: Text(
                    "Add Game",
                  ),
                ),
                value: FilterOptions.AddGame,
              )
            ],
          ),
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
          // controller.addGame();
        },
      ),
    );
  }
}
