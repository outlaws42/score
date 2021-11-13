import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../screen.dart';
import '../../controllers/providers.dart';
import '../function_helpers.dart';

class PopupDialogWidgets {
  static Widget plusMinusButton({
    required BuildContext context,
    required int score,
    required String player,
    required int playerIndex,
    required int id,
    // required String playerName,
    required String sign,
    required int amount,
    required int winScore,
    required bool freePlay,
    // required String player1Name,
    // required String player2Name,
    // required int player1Id,
    // required int player2Id,
    // required int player1Score,
    // required int player2Score,
    // required bool lowScore,
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
                        playerIndex: playerIndex,
                        player: player,
                        addAmount: amount,
                      )
                  : context.read(matchProvider).minus(
                        id: id,
                        score: score,
                        playerIndex: playerIndex,
                        player: player,
                        minusAmount: amount,
                      );
              Get.back();
              // print('This is the score ${score + amount}');
              // if (score + amount == winScore && freePlay == false) {
              //   if (playerName == player1Name) {
              //     player1Score = player1Score + amount;
              //   } else if (playerName == player2Name) {
              //     player2Score = player2Score + amount;
              //   }

              //   FunctionHelper.checkWinner(
              //     context: context,
              //     player1Score: player1Score,
              //     player2Score: player2Score,
              //     player1Id: player1Id,
              //     player2Id: player2Id,
              //     player1Name: player1Name,
              //     player2Name: player2Name,
              //     lowScore: lowScore,
              //     matchId: id,
              //   );
              //   // Get.back();
              // }
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
    required int playerIndex,
    required int id,
    // required String playerName,
    required String sign,
    required int winScore,
    required bool freePlay,
    // required String player1Name,
    // required String player2Name,
    // required int player1Id,
    // required int player2Id,
    // required int player1Score,
    // required int player2Score,
    required bool lowScore,
  }) {
    //  int index = 0;
    //  List match = context.read(matchProvider).match;
    bool isDisabled = false;
    Get.defaultDialog(
      radius: 10.0,
      title: sign == "add" ? "Add Amount" : "Subtract Amount",
      content: Column(
        children: [
          Text(
            freePlay == true ? "" : 'Points left to win ${winScore - score}',
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
                playerIndex: playerIndex,
                id: id,
                // playerName: playerName,
                sign: sign,
                amount: 5,
                winScore: winScore,
                freePlay: freePlay,
                // player1Score: player1Score,
                // player2Score: player2Score,
                // player1Id: player1Id,
                // player2Id: player2Id,
                // player1Name: player1Name,
                // player2Name: player2Name,
                // lowScore: lowScore,
              ),
              // 10 Button
              PopupDialogWidgets.plusMinusButton(
                context: context,
                score: score,
                player: player,
                playerIndex: playerIndex,
                id: id,
                // playerName: playerName,
                sign: sign,
                amount: 10,
                winScore: winScore,
                freePlay: freePlay,
                // player1Score: player1Score,
                // player2Score: player2Score,
                // player1Id: player1Id,
                // player2Id: player2Id,
                // player1Name: player1Name,
                // player2Name: player2Name,
                // lowScore: lowScore,
              ),
              // 15 Button

              PopupDialogWidgets.plusMinusButton(
                context: context,
                score: score,
                player: player,
                playerIndex: playerIndex,
                id: id,
                // playerName: playerName,
                sign: sign,
                amount: 15,
                winScore: winScore,
                freePlay: freePlay,
                // player1Score: player1Score,
                // player2Score: player2Score,
                // player1Id: player1Id,
                // player2Id: player2Id,
                // player1Name: player1Name,
                // player2Name: player2Name,
                // lowScore: lowScore,
              ),
              // 30 Button
              PopupDialogWidgets.plusMinusButton(
                context: context,
                score: score,
                player: player,
                playerIndex: playerIndex,
                id: id,
                // playerName: playerName,
                sign: sign,
                amount: 30,
                winScore: winScore,
                freePlay: freePlay,
                // player1Score: player1Score,
                // player2Score: player2Score,
                // player1Id: player1Id,
                // player2Id: player2Id,
                // player1Name: player1Name,
                // player2Name: player2Name,
                // lowScore: lowScore,
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
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              onChanged: (value) {
                if (score + int.parse(value) > winScore && freePlay == false) {
                  isDisabled = true;
                }
              },
              onFieldSubmitted: (value) {
                isDisabled == true && freePlay == false
                    ? Get.back()
                    : sign == "add"
                        ? context.read(matchProvider).plus(
                              id: id,
                              score: score,
                              playerIndex: playerIndex,
                              player: player,
                              addAmount: int.parse(value),
                            )
                        : context.read(matchProvider).minus(
                              id: id,
                              score: score,
                              playerIndex: playerIndex,
                              player: player,
                              minusAmount: int.parse(value),
                            );

                Get.back();
                // print('This is the score ${score + int.parse(value)}');
                // if (score + int.parse(value) == winScore && freePlay == false) {
                //   if (playerName == player1Name) {
                //     player1Score = player1Score + int.parse(value);
                //   } else if (playerName == player2Name) {
                //     player2Score = player2Score + int.parse(value);
                //   }

                //   FunctionHelper.checkWinner(
                //     context: context,
                //     player1Score: player1Score,
                //     player2Score: player2Score,
                //     player1Id: player1Id,
                //     player2Id: player2Id,
                //     player1Name: player1Name,
                //     player2Name: player2Name,
                //     lowScore: lowScore,
                //     matchId: id,
                //   );
                //   // Get.back();
                // }
              },
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                decorationColor: Colors.teal,
              ),
              decoration: InputDecoration(
                labelText: sign == "add" ? "+ Amount" : "- Amount",
                labelStyle: TextStyle(
                  color: isDisabled == true
                      ? Colors.red
                      : Theme.of(context).colorScheme.primary,
                ),
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
          Icon(
            Icons.dangerous,
            color: Colors.red,
            size: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                " Do you want to delete? $item",
                style: Theme.of(context).textTheme.headline6,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: Row(
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
                    if (screen == "player") {
                      context.read(playerProvider).deletePlayer(itemId);
                    } else if (screen == "match") {
                      context.read(matchProvider).deleteMatch(itemId);
                    } else if (screen == "game") {
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
          ),
        ],
      ),
    );
  }

  static confirmBackupDialog({
    required BuildContext context,
    required String dbFile,
  }) {
    Get.defaultDialog(
      radius: 10.0,
      title: "Warning",
      content: Column(
        children: [
          Icon(
            Icons.dangerous,
            color: Colors.red,
            size: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    " Are you sure you want to restore?",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Text(
                    " It will overwrite the current database",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: Row(
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
                    FunctionHelper().restore(
                      context: context,
                    );
                  },
                  child: Text("Ok"),
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).appBarTheme.backgroundColor,
                    onPrimary: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static documentation({
    required BuildContext context,
    required String data,
    double popupHeightPercent = 75,
    double popupWidthPercent = 90,

  }) {
    var width = Screen.percentOfSizeRound(
      percent: popupWidthPercent,
      dimension: Screen.width(context),
    );
    var height = Screen.percentOfSizeRound(
      percent: popupHeightPercent,
      dimension: Screen.height(context),
    );
    print(width);
    print(height);
    
    Get.defaultDialog(
      title: "Score Help",
      radius: 10.0,
      content: Container(
        width: width,
        height: height,
        // padding: EdgeInsets.all(20),
        child: FutureBuilder(
          future: rootBundle.loadString(data),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.hasData) {
              return Markdown(
                data: snapshot.data!,
                styleSheet: MarkdownStyleSheet(
                  // h1: TextStyle(color: Colors.blue, fontSize: 40),
                  p: Theme.of(context).textTheme.bodyText1,
                  h1: Theme.of(context).textTheme.headline2,
                  h2: Theme.of(context).textTheme.headline4,
                  h3: Theme.of(context).textTheme.headline6,
                  h4: Theme.of(context).textTheme.headline4,
                  h5: Theme.of(context).textTheme.headline5,
                  h6: Theme.of(context).textTheme.headline6,
                  listBullet: Theme.of(context).textTheme.bodyText1,
                  strong: Theme.of(context).textTheme.headline6,
                  code: Theme.of(context).textTheme.headline6,
                  // codeblockDecoration: ,
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
