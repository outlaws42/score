import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class Match extends StatefulWidget {
  @override
  State<Match> createState() => _MatchState();
}

class _MatchState extends State<Match> {
  // Color currentColor = Colors.green;
  // String dataFromPlayer = "Select Player";
  List arguments = Get.arguments;
  String _game = 'Select Game';
  int _endScore = 0;
  int _id = 0;

  
  void goToGame() async {
    var dataFromGame = await Get.toNamed(
      "/games",
      arguments: ['match', ''],
    );
    print(dataFromGame);
    _game = dataFromGame[0];
    _endScore = dataFromGame[1];
    _id = dataFromGame[2];
    print(_id);
    setState(() {});
  }

  // void _showDialog() {
  //   Get.defaultDialog(
  //       title: "Select Color",
  //       content: BlockPicker(
  //         pickerColor: currentColor,
  //         onColorChanged: changeColor,
  //         // colorPickerWidth: 300.0,
  //         // pickerAreaHeightPercent: 0.5,
  //         // enableAlpha: true,
  //         // displayThumbColor: true,
  //         // showLabel: true,
  //         // paletteType: PaletteType.hsv,
  //         // pickerAreaBorderRadius: const BorderRadius.all(
  //         //   Radius.circular(10.0)
  //         // ),
  //       ));
  // }

  @override
  Widget build(BuildContext context) {
    //final firstName = Provider.of<PlayerProvider>(context, listen: false).fetchPlayer();
    // var _names = Provider.of<PlayerProvider>(context, listen: false).fetchPlayer() ;
    // print("This is names $players");

    return Container(
      constraints: BoxConstraints(maxHeight: 60),
      child: Card(
        elevation: 6,
        color: Theme.of(context).appBarTheme.backgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Row Top Name/Menu
            Container(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Select Player
                  TextButton(
                    onPressed: () => goToGame(),
                        child: Text('$_game ($_endScore)',
                            style: Theme.of(context).textTheme.headline3),
                  ),

                  // Color Picker
                  // TextButton(
                  //   onPressed: () => _showDialog(),
                  //   child: Icon(Icons.color_lens),
                  //   style: ElevatedButton.styleFrom(
                  //     // primary: Theme.of(context).appBarTheme.backgroundColor,
                  //     onPrimary: Colors.white,
                  //   ),
                  // ),
                ],
              ),
            ),
            // Row 2 minus button score positive button
            // Container(
            //   padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //     children: [
            //       // Minus Button
            //       TextButton(
            //         onPressed: minusOne,
            //         onLongPress: () {},
            //         child: Icon(Icons.exposure_minus_1),
            //         style: ElevatedButton.styleFrom(
            //           // primary: Theme.of(context).appBarTheme.backgroundColor,
            //           onPrimary: Colors.white,
            //         ),
            //       ),
            //       Text(
            //         '$_score',
            //         style: Theme.of(context).textTheme.headline1,
            //       ),
            //       // Plus Button
            //       TextButton(
            //         onPressed: plusOne,
            //         onLongPress: () {},
            //         child: Icon(Icons.plus_one),
            //         style: ElevatedButton.styleFrom(
            //           // primary: Theme.of(context).appBarTheme.backgroundColor,
            //           onPrimary: Colors.white,
            //         ),
            //       ),
            //     ],
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
