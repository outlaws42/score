import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
// import '../controllers/game_provider.dart';
import '../controllers/game_controller.dart';

class GameList extends StatelessWidget {
  final GameController gameController = Get.find();
  Widget _listItem(index, game, context) {
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
          // leading: Text(
          //   '${play.player[index].id.toString()}',
          //   style: Theme.of(context).textTheme.headline6,
          // ),
          title: Text(
            '${game.games[index].name.toString()}',
            style: Theme.of(context).textTheme.headline6,
          ),
          subtitle: Text(
            '${game.games[index].description.toString()}',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          trailing: Container(
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
              '${game.games[index].endScore.toString()}',
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
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
  Widget build(BuildContext context) {
    //final firstName = Provider.of<PlayerProvider>(context, listen: false).fetchPlayer();

    return GetX<GameController>(
      builder: (_) => ListView.builder(
          // separatorBuilder: (context, index) => Divider(
          //       height: 0,
          //       thickness: 1,
          //       indent: 0,
          //       endIndent: 0,
          //     ),
          itemCount: _.games.length,
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
                  _listItem(index, _, context)
                ],
              );
            } else
              return _listItem(index, _, context);
          }),
    );
  }
}
