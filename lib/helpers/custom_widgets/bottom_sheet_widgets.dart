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
              : ListView.builder(
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
                            "${_wins[index].matchName} ${_wins[index].gameName}",
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          subtitle: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "${_wins[index].player1Name}:  ${_wins[index].player1Score}",
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                              Text(
                                "${_wins[index].player2Name}: ${_wins[index].player2Score}",
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
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
