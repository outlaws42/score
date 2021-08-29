import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:score/screens/player_screen.dart';
import 'package:score/widgets/player_body.dart';
import '../providers/player_provider.dart';

class MainBody extends StatefulWidget {
  @override
  State<MainBody> createState() => _MainBodyState();
}

class _MainBodyState extends State<MainBody> {
  var players;
  var names = ['Troy', 'Cara', 'Emily', 'Aaron', 'Todd'];
  // var _currentItemSelected = 'Troy';
  int _score = 0;
  void minusOne() {
    setState(() {
      _score++;
    });
    print(_score);
  }

  // void checkForNames() {
  //   // _isLoading = true;

  //   Provider.of<PlayerProvider>(context, listen: false).fetchPlayer().then((_) {
  //     var player = Provider.of<PlayerProvider>(context, listen: false).player;
  //     setState(() {
  //       players = player;
  //     });

  //   });
  // }

  // void initState() {
  //   super.initState();
  //   checkForNames();
  // }

  @override
  Widget build(BuildContext context) {
    //final firstName = Provider.of<PlayerProvider>(context, listen: false).fetchPlayer();
    // var _names = Provider.of<PlayerProvider>(context, listen: false).fetchPlayer() ;
    print("This is names $players");

    return Container(
      constraints: BoxConstraints(maxHeight: 175),
      child: Card(
        elevation: 6,
        color: Theme.of(context).primaryColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Row Top Name/Menu
            Container(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () =>  Navigator.of(context).pushNamed(PlayersScreen.routeName), 
                    child: Text('Troy',style: Theme.of(context).textTheme.headline3),
                    ),
                  // DropdownButton<String>(
                  //   items: names.map((String dropDownStringItem) {
                  //     return DropdownMenuItem(
                  //       value: dropDownStringItem,
                  //       child: Text(dropDownStringItem,
                  //           style: Theme.of(context).textTheme.headline3),
                  //     );
                  //   }).toList(),
                  //   onChanged: (String? newValueSelected) {
                  //     _dropDownItemSelected(newValueSelected);
                  //   },
                  //   value: _currentItemSelected,
                  //   underline: DropdownButtonHideUnderline(child: Container()),
                  //   dropdownColor:
                  //       Theme.of(context).appBarTheme.backgroundColor,
                  // ),
                  ElevatedButton(
                    onPressed: () {},
                    onLongPress: () {},
                    child: Icon(Icons.add_circle),
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).appBarTheme.backgroundColor,
                      onPrimary: Colors.white,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Icon(Icons.more),
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).appBarTheme.backgroundColor,
                      onPrimary: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            // Row 2 minus button score positive button
            Container(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _score -= 1;
                      });
                    },
                    onLongPress: () {},
                    child: Icon(Icons.exposure_minus_1),
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).appBarTheme.backgroundColor,
                      onPrimary: Colors.white,
                    ),
                  ),
                  Text(
                    '$_score',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  ElevatedButton(
                    onPressed: minusOne,
                    onLongPress: () {},
                    child: Icon(Icons.plus_one),
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).appBarTheme.backgroundColor,
                      onPrimary: Colors.white,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // // void _dropDownItemSelected(newValueSelected) {
  // //   setState(() {
  // //     this._currentItemSelected = newValueSelected!;
  // //   });
  // }
}
