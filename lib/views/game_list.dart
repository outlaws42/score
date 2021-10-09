import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/providers.dart';
import '../helpers/custom_widgets/page_widgets.dart';


class GameList extends ConsumerWidget {
  
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    //final firstName = Provider.of<PlayerProvider>(context, listen: false).fetchPlayer();
    final _game = watch(gameProvider).games;
    return _game.length == 0
        ? PageWidgets().noData(
            context: context,
            pageName: 'game',
            pageLink: '/game_form',
          )
        : ListView.builder(
            itemCount: _game.length,
            itemBuilder: (ctx, index) {
              if (index == 0) {
                return Column(
                  children: [
                    PageWidgets().header(
                      context: context,
                      column1: 'Game',
                      column2: 'Winning Score',
                    ),
                    PageWidgets().listItemGame(
                      context: context,
                      index: index,
                      game: _game,
                    )
                  ],
                );
              } else
                return PageWidgets().listItemGame(
                  context: context,
                  index: index,
                  game: _game,
                );
            },
          );
    // );
  }
}
