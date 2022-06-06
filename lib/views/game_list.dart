import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/providers.dart';
import '../helpers/custom_widgets/page_widgets.dart';
import './splash_screen.dart';

class GameList extends StatefulWidget {
  @override
  State<GameList> createState() => _GameListState();
}

class _GameListState extends State<GameList> {
  Future? _games;
  @override
  void initState() { 
    super.initState();

    _games = context.read(gameProvider).fetchGame();
  }

  Widget build(BuildContext context) {
    return Consumer(
      builder: (context,game,child) {
        final _game = game(gameProvider).games;
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
        );
      }
    );
  }
}
