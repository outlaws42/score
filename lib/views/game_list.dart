import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import '../helpers/function_helpers.dart';
import '../controllers/providers.dart';
import '../helpers/custom_widgets/page_widgets.dart';
import './game_form.dart';
// import 'package:provider/provider.dart';
// import 'package:get/get.dart';
// import '../controllers/game_provider.dart';
// import '../controllers/game_provider.dart';

// final gameProvider = ChangeNotifierProvider<GameProvider>((ref) => GameProvider());

class GameList extends ConsumerWidget {
  showBottomSheet({
    required BuildContext context,
    required String game,
    required String description,
    required String date,
  }) {
    Get.bottomSheet(
      Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            child: ListTile(
              // leading: ,
              title: Text(
                "$game",
                style: Theme.of(context).textTheme.headline6,
              ),
              subtitle: Text(
                "$description",
                style: Theme.of(context).textTheme.subtitle1,
              ),

              trailing: Text('$date'),
            ),
          ),
          // }),
        ),
      ),
    );
  }

  Widget _listItem(index, game, context) {
    List _selectedItems = [];
    var arguments = Get.arguments;
    final _id = game[index].id;
    final _game = game[index].name;
    final _description = game[index].description;
    final _endScore = game[index].endScore;
    final _lowScore = game[index].lowScore;
    final _freePlay = game[index].freePlay;
    final _date =
        FunctionHelper().convertToDate(dateTimeUtcInt: game[index].dateTime);
    String _firstDesc = "";

    if (_description.length > 29) {
      _firstDesc = _description.substring(0, 29);
    } else {
      _firstDesc = _description;
    }

    return Container(
      padding: const EdgeInsets.all(2),
      child: Card(
        elevation: 3,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: ListTile(
          leading: Text(
            '$_id',
            style: Theme.of(context).textTheme.headline4,
          ),
          title: Text(
            '$_game',
            style: Theme.of(context).textTheme.headline4,
          ),
          subtitle: Text(
            '$_firstDesc',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          trailing: _freePlay == true
              ? PageWidgets().circleContainer(
                  context: context,
                  content: 'FP',
                )
              : PageWidgets().circleContainer(
                  context: context,
                  content: _endScore.toString(),
                ),
          onTap: () {
            if (arguments[0] == 'match' || arguments[0] == 'form') {
              _selectedItems = [_game, _endScore, _id, _lowScore, _freePlay];
              // play.player[index].firstName; // assign first name
              print(_selectedItems);
              Get.back(result: _selectedItems);
            } else {
              print(arguments[0]);
              showBottomSheet(
                context: context,
                game: _game,
                description: _description,
                date: _date,
                // _endScore,
                // _id,
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
    final _game = watch(gameProvider).games;
    return _game.length == 0
        ? PageWidgets().noData(
            context: context,
            pageName: 'game',
            pageLink:'/game_form',
          )
        : ListView.builder(
            itemCount: _game.length,
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
                    _listItem(index, _game, context)
                  ],
                );
              } else
                return _listItem(index, _game, context);
            },
          );
    // );
  }
}
