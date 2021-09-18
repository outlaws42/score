import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../controllers/providers.dart';

class DialogConfig {
  // static addButton(BuildContext context, int arguments, int score,
  //     String player, int amount) {
  //   TextButton(
  //     onPressed: () {
  //       context.read(matchProvider).plusOne(
  //             id: arguments,
  //             score: score,
  //             player: player,
  //             addAmount: amount,
  //           );
  //       Get.back();
  //     },
  //     child: Text("$amount"),
  //     style: ElevatedButton.styleFrom(
  //       primary: Theme.of(context).appBarTheme.backgroundColor,
  //       onPrimary: Colors.white,
  //     ),
  //   );
  // }

  static addDialog(
    BuildContext context,
    score,
    player,
    arguments,
    playerName
  ) {
    Get.defaultDialog(
      title: "Add Amount",
      content: Column(
        children: [
          Text(
            '$playerName',
            style: Theme.of(context).textTheme.headline3,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  context.read(matchProvider).plusOne(
                        id: arguments,
                        score: score,
                        player: player,
                        addAmount: 5,
                      );
                  Get.back();
                },
                child: Text("+5"),
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).appBarTheme.backgroundColor,
                  onPrimary: Colors.white,
                ),
              ),
              TextButton(
                onPressed: () {
                  context.read(matchProvider).plusOne(
                        id: arguments,
                        score: score,
                        player: player,
                        addAmount: 10,
                      );
                  Get.back();
                },
                child: Text("+10"),
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).appBarTheme.backgroundColor,
                  onPrimary: Colors.white,
                ),
              ),
              TextButton(
                onPressed: () {
                  context.read(matchProvider).plusOne(
                        id: arguments,
                        score: score,
                        player: player,
                        addAmount: 15,
                      );
                  Get.back();
                },
                child: Text("+15"),
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).appBarTheme.backgroundColor,
                  onPrimary: Colors.white,
                ),
              ),
              TextButton(
                onPressed: () {
                  context.read(matchProvider).plusOne(
                        id: arguments,
                        score: score,
                        player: player,
                        addAmount: 30,
                      );
                  Get.back();
                },
                child: Text("+30"),
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

  static minusDialog(
    BuildContext context,
    score,
    player,
    arguments,
    playerName
  ) {
    Get.defaultDialog(
      title: "Subtract Amount",
      content: Column(
        children: [
          Text(
            '$playerName',
            style: Theme.of(context).textTheme.headline3,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  context.read(matchProvider).minusOne(
                        id: arguments,
                        score: score,
                        player: player,
                        minusAmount: 5,
                      );
                  Get.back();
                },
                child: Text("-5"),
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).appBarTheme.backgroundColor,
                  onPrimary: Colors.white,
                ),
              ),
              TextButton(
                onPressed: () {
                  context.read(matchProvider).minusOne(
                        id: arguments,
                        score: score,
                        player: player,
                        minusAmount: 10,
                      );
                  Get.back();
                },
                child: Text("-10"),
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).appBarTheme.backgroundColor,
                  onPrimary: Colors.white,
                ),
              ),
              TextButton(
                onPressed: () {
                  context.read(matchProvider).minusOne(
                        id: arguments,
                        score: score,
                        player: player,
                        minusAmount: 15,
                      );
                  Get.back();
                },
                child: Text("-15"),
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).appBarTheme.backgroundColor,
                  onPrimary: Colors.white,
                ),
              ),
              TextButton(
                onPressed: () {
                  context.read(matchProvider).minusOne(
                        id: arguments,
                        score: score,
                        player: player,
                        minusAmount: 30,
                      );
                  Get.back();
                },
                child: Text("-30"),
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
