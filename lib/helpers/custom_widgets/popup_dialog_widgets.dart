import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:score/helpers/function_helpers.dart';
import '../../controllers/providers.dart';

class PopupDialogWidgets {
  static Widget plusMinusButton({
    required BuildContext context,
    required int score,
    required String player,
    required int id,
    required String playerName,
    required String sign,
    required int amount,
    required int winScore,
    required bool freePlay,
  }) {
    bool isDisable = false;
    if (freePlay == true) {
      isDisable = false;
    } else if (amount + score > winScore && sign == "add" ||
        score - amount < 0 && sign == "minus") {
      isDisable = true;
    }
    return TextButton(
      onPressed: isDisable == true
          ? null
          : () {
              sign == "add"
                  ? context.read(matchProvider).plus(
                        id: id,
                        score: score,
                        player: player,
                        addAmount: amount,
                      )
                  : context.read(matchProvider).minus(
                        id: id,
                        score: score,
                        player: player,
                        minusAmount: amount,
                      );
              Get.back();
            },
      child: sign == "add" ? Text("+$amount") : Text("-$amount"),
      style: ElevatedButton.styleFrom(
        primary: Theme.of(context).appBarTheme.backgroundColor,
        onPrimary: Colors.white,
      ),
    );
  }

  static mathDialog({
    required BuildContext context,
    required int score,
    required String player,
    required int id,
    required String playerName,
    required String sign,
    required int winScore,
    required bool freePlay,
  }) {
    bool isDisabled = false;
    Get.defaultDialog(
      radius: 10.0,
      title: sign == "add" ? "Add Amount" : "Subtract Amount",
      content: Column(
        children: [
          Text(freePlay == true ? "" :
            'Points left to win ${winScore - score}',
            style: Theme.of(context).textTheme.headline6,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // 5 Button
              PopupDialogWidgets.plusMinusButton(
                context: context,
                score: score,
                player: player,
                id: id,
                playerName: playerName,
                sign: sign,
                amount: 5,
                winScore: winScore,
                freePlay: freePlay,
              ),
              // 10 Button
              PopupDialogWidgets.plusMinusButton(
                context: context,
                score: score,
                player: player,
                id: id,
                playerName: playerName,
                sign: sign,
                amount: 10,
                winScore: winScore,
                freePlay: freePlay,
              ),
              // 15 Button

              PopupDialogWidgets.plusMinusButton(
                context: context,
                score: score,
                player: player,
                id: id,
                playerName: playerName,
                sign: sign,
                amount: 15,
                winScore: winScore,
                freePlay: freePlay,
              ),
              // 30 Button
              PopupDialogWidgets.plusMinusButton(
                context: context,
                score: score,
                player: player,
                id: id,
                playerName: playerName,
                sign: sign,
                amount: 30,
                winScore: winScore,
                freePlay: freePlay,
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Divider(
              height: 0,
              thickness: 2,
              indent: 0,
              endIndent: 0,
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(75, 10, 75, 0),
            child: TextFormField(
              maxLength: 3,
              // textCapitalization: TextCapitalization.words,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              onChanged: (value){
                print(value);
                if (score + int.parse(value) > winScore){
                  isDisabled = true;
                  print("The Input is to higher then the score to win");
                }
              },
              onFieldSubmitted: (value) {
                // int.parse(value) + score > winScore ?
                isDisabled == true ? Get.back() :
                sign == "add"
                    ? context.read(matchProvider).plus(
                          id: id,
                          score: score,
                          player: player,
                          addAmount: int.parse(value),
                        )
                    : context.read(matchProvider).minus(
                          id: id,
                          score: score,
                          player: player,
                          minusAmount: int.parse(value),
                        ); //: print("Over Amount");
                  
                Get.back();
              },
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                decorationColor: Colors.teal,
              ),
              decoration: InputDecoration(
                labelText: sign == "add" ? "+ Amount" : "- Amount",
                labelStyle: TextStyle(
                  color: isDisabled == true ? Colors.red : Theme.of(context).colorScheme.primary,
                ),
                // hintText: hintText,
                hintStyle: TextStyle(
                  color: Theme.of(context).colorScheme.secondaryVariant,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primaryVariant,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static winDialog(BuildContext context, currentPlayer) {
    Get.defaultDialog(
      radius: 10.0,
      title: "The Game Is Complete",
      content: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.beach_access,
                color: Colors.green,
              ),
              Text(
                " $currentPlayer",
                style: Theme.of(context).textTheme.headline6,
              ),
              Text(
                " Won The Game",
                style: Theme.of(context).textTheme.headline6,
              ),
            ],
          ),
          TextButton(
            onPressed: () => Get.back(),
            child: Text("Ok"),
            style: ElevatedButton.styleFrom(
              primary: Theme.of(context).appBarTheme.backgroundColor,
              onPrimary: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  static warnDialog(
    BuildContext context,
    String item,
    int itemId,
    String screen,
  ) {
    Get.defaultDialog(
      radius: 10.0,
      title: "Warning",
      content: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.beach_access,
                color: Colors.green,
              ),
              Text(
                " Do you want to delete? $item",
                style: Theme.of(context).textTheme.headline6,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () => Get.back(),
                child: Text("Cancel"),
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).appBarTheme.backgroundColor,
                  onPrimary: Colors.white,
                ),
              ),
              TextButton(
                onPressed: () {
                  Get.back();
                  if(screen == "player"){
                    context.read(playerProvider).deletePlayer(itemId);
                  } else if(screen == "match"){
                  context.read(matchProvider).deleteMatch(itemId);
                  } else if(screen == "game"){
                  context.read(gameProvider).deleteGame(itemId);
                  } else {
                    print("nothing to delete here");
                  }
                },
                child: Text("Delete"),
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).appBarTheme.backgroundColor,
                  onPrimary: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
