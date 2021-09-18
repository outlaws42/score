import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:score/controllers/providers.dart';

class Match extends StatelessWidget {
  final int arguments;
  Match({
    this.arguments = 1,
  });

  @override
  Widget build(BuildContext context) {
    
    return Container(
      constraints: BoxConstraints(maxHeight: 60),
      child: Card(
        elevation: 6,
        color: Theme.of(context).appBarTheme.backgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Select Player
                  Consumer(
                    builder: (context,watch,child) {
                      final gameData = watch(matchProvider);
                      final _gameName = gameData.match[arguments-1].gameName;
                      return TextButton(
                        onPressed: () {},
                            child: Text('$_gameName',
                                style: Theme.of(context).textTheme.headline3),
                      );
                    }
                  ),

                ],
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}
