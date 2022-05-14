import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../helpers/custom_widgets/page_widgets.dart';
import '../controllers/providers.dart';

class MatchList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final _match = watch(matchProvider).match;
    // final _matchh = watch(matchProvider).fetchMatchHttp('10.0.2.2', '5000', 'matches');
    // print('match length: ${_match.length}');

    return _match.length == 0
        ? PageWidgets().noData(
            context: context,
            pageName: 'match',
            pageLink: '/match_form',
          )
        : Column(
            children: [
              PageWidgets().header(
                context: context,
                column1: 'Match',
                column2: 'Win Mode',
              ),
              Expanded(
                child: RefreshIndicator(
                  child: ListView.builder(
                    itemCount: _match.length,
                    itemBuilder: (ctx, index) {
                      var _players = [];
                      for (var i in _match[index].players)
                        _players.add(i.playerName);

                      return PageWidgets().listItemMatch(
                          context: context,
                          index: index,
                          match: _match,
                          players: _players);
                    },
                    physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                  ),
                  onRefresh: () async {
                    await context.read(matchProvider).fetchMatch();
                  },
                ),
              ),
            ],
          );
  }
}
