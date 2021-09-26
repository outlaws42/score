import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
class WinnerConfig {

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
                style: Theme.of(context).textTheme.headline5,
              ),
              Text(" Won The Game"),
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

}
