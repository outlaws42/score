import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import '../controllers/providers.dart';
// import 'package:provider/provider.dart';
// import 'package:get/get.dart';
// import '../controllers/game_provider.dart';
// import '../controllers/game_provider.dart';

// final gameProvider = ChangeNotifierProvider<GameProvider>((ref) => GameProvider());

class GameList extends ConsumerWidget {
  
  showBottomSheet(game, description, endscore, id) {
    Get.bottomSheet(
      Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("$id"),
              Text("$game"),
              Text("$description"),
              Text("$endscore"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _listItem(index, game, context) {
    List _selectedItems = [];
    var arguments = Get.arguments;
    final _id = game.games[index].id;
    final _game = game.games[index].name;
    final _description = game.games[index].description;
    final _endScore = game.games[index].endScore;
    final _lowScore = game.games[index].lowScore;
    final _freePlay = game.games[index].freePlay;
    return Container(
      padding: const EdgeInsets.all(2),
      child: Card(
        elevation: 3,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: ListTile(
          // leading: CircleAvatar(
          //   backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          //   child: Text(
          //     '${play.player[index].id.toString()}',
          //     style: Theme.of(context).textTheme.headline3,
          //   ),
          // ),
          leading: Text(
            '$_id',
            style: Theme.of(context).textTheme.headline6,
          ),
          title: Text(
            '$_game',
            style: Theme.of(context).textTheme.headline6,
          ),
          subtitle: Text(
            '$_description',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          trailing: _freePlay == true ? Text("Free Play"):Container(
            alignment: Alignment.center,
            height: 30,
            width: 30,
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).appBarTheme.backgroundColor,
                boxShadow: [
                  BoxShadow(color: Colors.black26, blurRadius: 8.0),
                ]),
            child: Text(
              '$_endScore',
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
          onTap: () {
            if (arguments[0] == 'match' || arguments[0] == 'matchForm') {
              _selectedItems = [ _game, _endScore,_id, _lowScore, _freePlay];
                  // play.player[index].firstName; // assign first name
              print(_selectedItems);
              Get.back(result: _selectedItems);
            } else {
              print(arguments[0]);
              showBottomSheet(
                _game,
                _description,
                _endScore,
                _id,
              );
            }
          },
        ),
      ),
    );
  }

  Widget header(context) {
    return Card(
      elevation: 6,
      color: Theme.of(context).appBarTheme.backgroundColor,
      child: ListTile(
        // leading: Container(
        //   width: 30,
        //   alignment: Alignment.center,
        //   child: Text('Id', style: Theme.of(context).textTheme.headline5),
        // ),
        title: Text('Game', style: Theme.of(context).textTheme.headline3),
        trailing:
            Text('Wining Score', style: Theme.of(context).textTheme.headline3),
      ),
    );
  }

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    //final firstName = Provider.of<PlayerProvider>(context, listen: false).fetchPlayer();
    final gameWatch = watch(gameProvider);
    return ListView.builder(
      // separatorBuilder: (context, index) => Divider(
      //       height: 0,
      //       thickness: 1,
      //       indent: 0,
      //       endIndent: 0,
      //     ),
      itemCount: gameWatch.games.length,
      itemBuilder: (ctx, index) {
        if (index == 0) {
          return Column(
            children: [
              header(context),
              // Divider(
              //   height: 0,
              //   thickness: 4,
              //   indent: 0,
              //   endIndent: 0,
              // ),
              _listItem(index, gameWatch, context)
            ],
          );
        } else
          return _listItem(index, gameWatch, context);
      },
    );
    // );
  }
}
