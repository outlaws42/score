import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:flutter/widgets.dart';
import '../controllers/providers.dart';
import '../helpers/custom_widgets/page_widgets.dart';

class PlayerSelectList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    // List args = Get.arguments;
    final _player = watch(playerProvider);
    final _matchList = watch(matchProvider).match;
    // var _filterPlayer = args[0] == "form"
    //     ? _player.player.where((win) => win.id != int.parse(args[1])).toList()
    //     : _player.player;
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
                        player:_player.player,
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
}