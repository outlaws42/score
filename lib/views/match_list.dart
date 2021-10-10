import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../helpers/custom_widgets/page_widgets.dart';
import '../controllers/providers.dart';

class MatchList extends ConsumerWidget {
  
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final _match = watch(matchProvider).match;
    return _match.length == 0
        ? PageWidgets().noData(
            context: context,
            pageName: 'match',
            pageLink: '/match_form',
          )
        : ListView.builder(
            itemCount: _match.length,
            itemBuilder: (ctx, index) {
              if (index == 0) {
                return Column(
                  children: [
                    PageWidgets().header(
                        context: context,
                        column1: 'Match',
                        column2: 'Winning Score'),
                    PageWidgets().listItemMatch(
                      context: context,
                      index: index,
                      match: _match,
                    )
                  ],
                );
              } else
                return PageWidgets().listItemMatch(
                  context: context,
                  index: index,
                  match: _match,
                );
            },
          );
    // );
  }
}
