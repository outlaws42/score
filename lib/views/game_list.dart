import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/providers.dart';
import '../helpers/custom_widgets/page_widgets.dart';

class GameList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final _game = watch(gameProvider).games;
    return _game.length == 0
        ? PageWidgets().noData(
            context: context,
            pageName: 'game',
            pageLink: '/game_form',
          )
        : Column(
            children: [
              PageWidgets().header(
                context: context,
                column1: 'Game',
                column2: 'Winning Score',
              ),
              Expanded(
                child: RefreshIndicator(
                  child: ListView.builder(
                    itemCount: _game.length,
                    itemBuilder: (ctx, index) {
                      return PageWidgets().listItemGame(
                        context: context,
                        index: index,
                        game: _game,
                      );
                    },
                    physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                  ),
                  onRefresh: () async {
                    await context.read(gameProvider).fetchGame();
                  },
                ),
              ),
            ],
          );
  }
}
