import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/providers.dart';
import '../helpers/custom_widgets/page_widgets.dart';

class PlayerSelectList extends ConsumerStatefulWidget {
  @override
  _PlayerSelectListState createState() => _PlayerSelectListState();
}

class _PlayerSelectListState extends ConsumerState<PlayerSelectList> {
  Future? _players;
  @override
  void initState() {
    super.initState();

    _players = ref.read(playerProvider).fetchPlayer();
  }

  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final _player = ref.watch(playerProvider);
      final _playersSort = _player.player;
      _playersSort
          .sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
      final _matchList = ref.watch(matchProvider).match;
      return FutureBuilder(
          future: _players,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
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
                        ref: ref,
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
                                ref:ref,
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
                            await ref.read(playerProvider).fetchPlayer();
                          },
                        ),
                      ),
                    ],
                  );
          });
    });
  }
}
