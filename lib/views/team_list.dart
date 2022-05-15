import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:get/get.dart';
import 'package:flutter/widgets.dart';
import '../controllers/providers.dart';
import '../helpers/custom_widgets/page_widgets.dart';

class TeamList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final _player = watch(playerProvider);
    final _matchList = watch(matchProvider).match;
    return _player.player.length == 0
        ? PageWidgets().noData(
            context: context,
            pageName: 'player',
            pageLink: '/player_form',
          )
        : Column(
            children: [
              PageWidgets().header(
                context: context,
                column1: 'Name',
                column2: 'Wins',
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 
                      _player.player.length,
                  itemBuilder: (contex, index) {
                    if (index == 0) {
                      return PageWidgets().listItemPlayer(
                        context: context,
                        index: index,
                        player:_player.player,
                        matchList: _matchList,
                        playerProv: _player,
                      );
                    } else
                      return PageWidgets().listItemPlayer(
                        context: context,
                        index: index,
                        player:
                            _player.player,
                        matchList: _matchList,
                        playerProv: _player,
                      );
                  },
                ),
              ),
            ],
          );
  }
}
