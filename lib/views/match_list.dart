import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../helpers/custom_widgets/page_widgets.dart';
import '../controllers/providers.dart';

class MatchList extends StatefulWidget {
  @override
  State<MatchList> createState() => _MatchListState();
}

class _MatchListState extends State<MatchList> {
  Future? _matches;
  @override
  void initState() { 
    super.initState();

    _matches = context.read(matchProvider).fetchMatch();
  }

  Widget build(BuildContext context) {
    return Consumer(builder: (context, match, child) {
      final _match = match(matchProvider).match.toList();
      _match.sort((a, b) => b.isComplete ? -1 : 1);
      return FutureBuilder(
        future: _matches,
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator());
          }
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
                          await match(matchProvider).fetchMatch();
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
