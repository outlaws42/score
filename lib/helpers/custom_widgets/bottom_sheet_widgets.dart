import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
    // var _winsIndex = matchList.indexWhere((win) => win.winnerId == playerId);
    // var _player = matchList[_winsIndex]
    //     .players
    //     .where((win) => win.playerId == playerId)
    //     .toList();

    // print(_player);

    Get.bottomSheet(
      Container(
        color: Colors.white,
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
    required String date,
  }) {
    Get.bottomSheet(
      Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            child: ListTile(
              title: Text(
                "$game",
                style: Theme.of(context).textTheme.headline4,
              ),
              subtitle: Text(
                "$description",
                style: Theme.of(context).textTheme.subtitle1,
              ),
              trailing: Text(
                '$date',
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
          ),
        ),
      ),
    );
  }

  dbBackupSheet({
    required BuildContext context,
    required String url,
  }) {
    Get.bottomSheet(
      Container(
        color: Colors.white,
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
