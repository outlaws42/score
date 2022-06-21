import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/providers.dart';
import '../helpers/custom_widgets/page_widgets.dart';

class GameList extends ConsumerStatefulWidget {
  @override
  GameListState createState() => GameListState();
}

class GameListState extends ConsumerState<GameList> {
  Future? _games;
  @override
  void initState() { 
    super.initState();

    _games = ref.read(gameProvider).fetchGame();
  }

  Widget build(BuildContext context) {
    return Consumer(
      builder: (context,ref,child) {
        final _game = ref.watch(gameProvider).games;
    _game.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
        return FutureBuilder(
          future: _games,
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator());
          }
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
                        column2: 'Win Mode',
                      ),
                      Expanded(
                        child: RefreshIndicator(
                          child: ListView.builder(
                            itemCount: _game.length,
                            itemBuilder: (ctx, index) {
                              return PageWidgets().listItemGame(
                                ref: ref,
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
                            await ref.read(gameProvider).fetchGame();
                          },
                        ),
                      ),
                    ],
                  );
          }
        );
      }
    );
  }
}
