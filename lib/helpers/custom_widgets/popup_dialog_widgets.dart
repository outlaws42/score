import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../screen.dart';
import '../../controllers/providers.dart';
// import '../function_helpers.dart';

class PopupDialogWidgets {
  static Widget plusMinusButton({
    required WidgetRef ref,
    required BuildContext context,
    required int score,
    required String player,
    required int playerIndex,
    required String id,
    required String sign,
    required int amount,
  }) {
    bool isDisable = false;
    if (score - amount < 0 && sign == "minus") {
      isDisable = true;
    }
    return TextButton(
      onPressed: isDisable == true
          ? null
          : () {
              sign == "add"
                  ? ref.read(matchProvider).plus(
                        id: id,
                        score: score,
                        playerIndex: playerIndex,
                        player: player,
                        addAmount: amount,
                      )
                  : ref.read(matchProvider).minus(
                        id: id,
                        score: score,
                        playerIndex: playerIndex,
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
    required WidgetRef ref,
    required BuildContext context,
    required int score,
    required String player,
    required int playerIndex,
    required String id,
    required String sign,
    required bool lowScore,
  }) {
    bool isDisabled = false;
    Get.defaultDialog(
      radius: 10.0,
      title: sign == "add" ? "Add Amount" : "Subtract Amount",
      backgroundColor: Theme.of(context).appBarTheme.foregroundColor,
      content: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // 5 Button
              PopupDialogWidgets.plusMinusButton(
                ref: ref,
                context: context,
                score: score,
                player: player,
                playerIndex: playerIndex,
                id: id,
                sign: sign,
                amount: 5,
                  ),
              // 10 Button
              PopupDialogWidgets.plusMinusButton(
                ref: ref,
                context: context,
                score: score,
                player: player,
                playerIndex: playerIndex,
                id: id,
                sign: sign,
                amount: 10,
              ),
              // 15 Button

              PopupDialogWidgets.plusMinusButton(
                ref:ref,
                context: context,
                score: score,
                player: player,
                playerIndex: playerIndex,
                id: id,
                sign: sign,
                amount: 15,
              ),
              // 30 Button
              PopupDialogWidgets.plusMinusButton(
                ref:ref,
                context: context,
                score: score,
                player: player,
                playerIndex: playerIndex,
                id: id,
                sign: sign,
                amount: 30,
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
              },
              onFieldSubmitted: (value) {
                    sign == "add"
                        ? ref.read(matchProvider).plus(
                              id: id,
                              score: score,
                              playerIndex: playerIndex,
                              player: player,
                              addAmount: int.parse(value),
                            )
                        : ref.read(matchProvider).minus(
                              id: id,
                              score: score,
                              playerIndex: playerIndex,
                              player: player,
                              minusAmount: int.parse(value),
                            );

                Get.back();
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
                  color: Theme.of(context).colorScheme.secondaryContainer,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primaryContainer,
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
      backgroundColor: Theme.of(context).appBarTheme.foregroundColor,
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
    WidgetRef ref,
    BuildContext context,
    String item,
    String itemId,
    String screen,
  ) {
    Get.defaultDialog(
      radius: 10.0,
      title: "Warning",
      backgroundColor: Theme.of(context).appBarTheme.foregroundColor,
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
                      ref.read(playerProvider).deletePlayer(itemId);
                    } else if (screen == "match") {
                      ref.read(matchProvider).deleteMatch(id:itemId);
                    } else if (screen == "game") {
                      ref.read(gameProvider).deleteGame(itemId);
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
      backgroundColor: Theme.of(context).appBarTheme.foregroundColor,
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
                    // FunctionHelper().restore(
                    //   context: context,
                    // );
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
      backgroundColor: Theme.of(context).appBarTheme.foregroundColor,
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
