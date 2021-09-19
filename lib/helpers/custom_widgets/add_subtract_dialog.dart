import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../controllers/providers.dart';

class DialogConfig {
  static Widget plusMinusButton({
    required BuildContext context,
    required int score,
    required String player,
    required int arguments,
    required String playerName,
    required String sign,
    required int amount,
  }) {
    return TextButton(
      onPressed: () {
        sign == "add"
            ? context.read(matchProvider).plus(
                  id: arguments,
                  score: score,
                  player: player,
                  addAmount: amount,
                )
            : context.read(matchProvider).minus(
                  id: arguments,
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
    required int arguments,
    required String playerName,
    required String sign,
  }) {
    Get.defaultDialog(
      title: sign == "add" ? "Add Amount" : "Subtract Amount",
      content: Column(
        children: [
          Text(
            '$playerName',
            style: Theme.of(context).textTheme.headline5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // 5 Button
              DialogConfig.plusMinusButton(
                context: context, 
                score: score, 
                player: player, 
                arguments: arguments, 
                playerName: playerName, 
                sign: sign, 
                amount: 5),
              // 10 Button
               DialogConfig.plusMinusButton(
                context: context, 
                score: score, 
                player: player, 
                arguments: arguments, 
                playerName: playerName, 
                sign: sign, 
                amount: 10),
                // 15 Button

               DialogConfig.plusMinusButton(
                context: context, 
                score: score, 
                player: player, 
                arguments: arguments, 
                playerName: playerName, 
                sign: sign, 
                amount: 15),
              // 30 Button
               DialogConfig.plusMinusButton(
                context: context, 
                score: score, 
                player: player, 
                arguments: arguments, 
                playerName: playerName, 
                sign: sign, 
                amount: 30),
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
              onFieldSubmitted: (value) {
                sign == "add"
                    ? context.read(matchProvider).plus(
                          id: arguments,
                          score: score,
                          player: player,
                          addAmount: int.parse(value),
                        )
                    : context.read(matchProvider).minus(
                          id: arguments,
                          score: score,
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
                  color: Theme.of(context).colorScheme.primary,
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
}
