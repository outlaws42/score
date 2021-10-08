import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/match_model.dart';
import '../function_helpers.dart';

class BottomSheetWidgets {
  playerSheet({
    required BuildContext buildContext,
    required int playerId,
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
                    // Text(
                    //     "$playerName",
                    //     style: Theme.of(buildContext).textTheme.headline2,
                    //   ),
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
                    final _date = FunctionHelper().convertToDate(
                      dateTimeUtcInt: _wins[index].dateTime,
                    );
                    return Container(
                      child: Card(
                        elevation: 3,
                        color: Theme.of(context).scaffoldBackgroundColor,
                        child: ListTile(
                          // leading: ,
                          title: Text(
                            "${_wins[index].matchName} ${_wins[index].gameName}",
                            style: Theme.of(context).textTheme.headline6,
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
                          trailing: Text('$_date'),
                        ),
                      ),
                    );
                  }),
        ),
      ),
    );
  }
}