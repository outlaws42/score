import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../models/match_model.dart';
import '../function_helpers.dart';

class BottomSheetWidgets {
  playerSheet({
    required BuildContext buildContext,
    required String playerId,
    required List<MatchModel> matchList,
    required String playerName,
  }) {
    var _wins = matchList.where((win) => win.winnerId == playerId).toList();

    Get.bottomSheet(
      Container(
        color: Theme.of(buildContext).appBarTheme.foregroundColor,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: _wins.length == 0
              ? Column(
                  children: [
                    Text(
                      "No wins Yet, Please keep trying",
                      style: Theme.of(buildContext).textTheme.headline2,
                    ),
                    Icon(
                      Icons.sentiment_dissatisfied,
                      size: 85,
                      color: Colors.grey,
                    ),
                  ],
                )
              // Build list for players
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: _wins.length,
                  itemBuilder: (context, index) {
                    final _date = FunctionHelper().intUtcToStringFormatDT(
                      dateTimeUtcInt: _wins[index].dateTime,
                    );
                    return Container(
                      child: Card(
                        elevation: 3,
                        color: Theme.of(context).scaffoldBackgroundColor,
                        child: ListTile(
                          title: Text(
                            "${_wins[index].gameName}",
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          subtitle: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Build list of players in the match of wins by player
                              ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: _wins[index].players.length,
                                  itemBuilder: (context, i) {
                                    return Container(
                                      child: Text(
                                        "${_wins[index].players[i].playerName} : ${_wins[index].players[i].score} ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1,
                                      ),
                                    );
                                  })
                            ],
                          ),
                          trailing: Text(
                            '$_date',
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ),
                      ),
                    );
                  }),
        ),
      ),
    );
  }

  gameSheet({
    required BuildContext context,
    required String game,
    required String description,
    String url = '',
    required String date,
  }) {
    bool isLink = true;
    if(url.isEmpty){
      isLink = false;
    }
    // Get.bottomSheet(
    //   Container(
    //     color: Theme.of(context).appBarTheme.foregroundColor,
    //     child: Padding(
    //       padding: const EdgeInsets.all(10.0),
    //       child: Container(
    //         child: ListTile(
    //           title: Text(
    //             "$game",
    //             style: Theme.of(context).textTheme.headline4,
    //           ),
    //           subtitle: Text(
    //             "$description",
    //             style: Theme.of(context).textTheme.subtitle1,
    //           ),
    //           trailing: Text(
    //             '$date',
    //             style: Theme.of(context).textTheme.subtitle1,
    //           ),
    //         ),
    //       ),
    //     ),
    //   ),
    // );

    Get.bottomSheet(Card(
      elevation: 6,
      color: Theme.of(context).appBarTheme.foregroundColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 100,
                  child:
                      Text(game, style: Theme.of(context).textTheme.headline4),
                ),
                Container(
                  width: 100,
                  child:
                      Text(date, style: Theme.of(context).textTheme.subtitle1),
                ),
              ],
            ),
            // Row(
            //   children: [
            Container(
              width: 350,
              child: Text(description,
                  style: Theme.of(context).textTheme.subtitle1),
            ),
            Container(
              width: 60,
              child: IconButton(
                icon: Icon(
                  MdiIcons.linkBoxVariant,
                  size: 60,
                  color: isLink == false ? null : Theme.of(context).appBarTheme.backgroundColor,
                ),
                onPressed: isLink == false ? null : () {
                  FunctionHelper.gameDescription(url);
                },
              ),
            ),
            //   ],
            // ),
            // ],
            // ),
          ],
        ),
      ),
    ));
  }

  dbBackupSheet({
    required BuildContext context,
    required String url,
  }) {
    Get.bottomSheet(
      Container(
        color: Theme.of(context).appBarTheme.foregroundColor,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            child: ListTile(
              title: Text(
                "The database was backed up at this location",
                style: Theme.of(context).textTheme.headline4,
              ),
              subtitle: Text(
                "$url",
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
