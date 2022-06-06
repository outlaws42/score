import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/providers.dart';
import '../helpers/custom_widgets/page_widgets.dart';
import './splash_screen.dart';

class PlayerSelectList extends StatefulWidget {
  @override
  State<PlayerSelectList> createState() => _PlayerSelectListState();
}

class _PlayerSelectListState extends State<PlayerSelectList> {
  Future? _players;
  @override
  void initState() { 
    super.initState();

    _players = context.read(playerProvider).fetchPlayer();
  }
  Widget build(BuildContext context) {
    return Consumer(builder: (context, builder, child) {
      final _player = builder(playerProvider);
      final _playersSort = _player.player;
      _playersSort
          .sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
      final _matchList = builder(matchProvider).match;
      return FutureBuilder(
        future: _players,
        builder: (context,snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator());
          }
          return _player.player.length == 0
              ? PageWidgets().noData(
                  context: context,
                  pageName: 'player',
                  pageLink: '/player_form',
                )
              : Column(
                  children: [
                    PageWidgets().headerButton(
                      context: context,
                      column1: 'Name',
                      column2: 'Wins',
                    ),
                    Expanded(
                      child: RefreshIndicator(
                        child: ListView.builder(
                          itemCount: _player.player.length,
                          itemBuilder: (contex, index) {
                            return PageWidgets().selectPlayer(
                              context: context,
                              index: index,
                              player: _playersSort,
                              matchList: _matchList,
                              playerProv: _player,
                            );
                          },
                          physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics(),
                          ),
                        ),
                        onRefresh: () async {
                          await context.read(playerProvider).fetchPlayer();
                        },
                      ),
                    ),
                  ],
                );
        }
      );
    });
  }
}
