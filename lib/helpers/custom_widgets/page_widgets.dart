import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PageWidgets{
  Widget noData({
    required BuildContext context,
    required String pageName,
    required Widget pageLink,
  }) {
    return Center(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text(
            //   'Tap',
            //   style: Theme.of(context).textTheme.headline5,
            // ),
            IconButton(
                  onPressed: ()=>Get.to(()=>pageLink),
                  icon: Icon(Icons.add_circle),
                  iconSize: 120,
                  color: Theme.of(context).appBarTheme.backgroundColor,
                ),
                Text(
              'Tap to add your first $pageName',
              style: Theme.of(context).textTheme.headline5,
            ),
          ],
        ),
      ),
    );
  }
}

