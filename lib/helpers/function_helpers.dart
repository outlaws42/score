import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../controllers/providers.dart';
import './custom_widgets/popup_dialog_widgets.dart';

class FunctionHelper {
  static checkWinner({
    required BuildContext context,
    required int player1Score,
    required int player2Score,
    required int player1Id,
    required int player2Id,
    required String player1Name,
    required String player2Name,
    required bool lowScore,
    required int matchId,
  }) {
    String winner = "_";
    int playerId = 1;
    if (lowScore == false && player1Score > player2Score) {
      winner = player1Name;
      playerId = player1Id;
    } else if (lowScore == false && player1Score < player2Score) {
      winner = player2Name;
      playerId = player2Id;
    } else if (lowScore == true && player1Score < player2Score) {
      winner = player1Name;
      playerId = player1Id;
    } else if (lowScore == true && player1Score > player2Score) {
      winner = player2Name;
      playerId = player2Id;
    }
    var _playerIndex = context
        .read(playerProvider)
        .player
        .indexWhere((element) => element.id == playerId);
    final _wins = context.read(playerProvider).player[_playerIndex].wins;
    context.read(matchProvider).updateWinner(
          matchId: matchId,
          winnerName: winner,
          winnerId: playerId,
        );

    // print(
    //     "winner of match $matchId is $winner");

    context.read(playerProvider).plus(
          id: playerId,
          wins: _wins,
          addAmount: 1,
        );
    PopupDialogWidgets.winDialog(context, winner);
  }

  convertToDate({
    required int dateTimeUtcInt,
    String format = 'yyy-MM-dd'
  }) {
    // Take int and returns date in the default format of YYYY-MM-DD
    DateTime dts = DateTime.fromMillisecondsSinceEpoch(dateTimeUtcInt);
    DateFormat dateFormat = DateFormat(format);
    String date = dateFormat.format(dts);
    return date;
  }
  updateSelected({
    required int id,
    required bool isSelected
  }) {
    isSelected = !isSelected;
    int isSelectedInt = isSelected == false ? 0 : 1;
    return isSelectedInt;
    // notifyListeners();
  }
}
