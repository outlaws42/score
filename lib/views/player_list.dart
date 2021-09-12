import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:flutter/widgets.dart';
import '../controllers/providers.dart';


class PlayerList extends ConsumerWidget {
  
  showBottomSheet(first, last, wins, id) {
    Get.bottomSheet(
      Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("$id"),
              Text("$first $last"),
              Text("$wins"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _listItem(index, play, context) {
    List _selectedItems = [];
    List arguments = Get.arguments;
    final _nameFirst = play.player[index].firstName;
    final _nameLast = play.player[index].lastName;
    final _wins = play.player[index].wins;
    final _id = play.player[index].id;
    final _ts = play.player[index].tempScore;
    print(arguments);
    return Container(
      padding: const EdgeInsets.all(2),
      child: Card(
        elevation: 3,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: ListTile(
          // leading: CircleAvatar(
          //   backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          //   child: Text(
          //     '${play.player[index].id.toString()}',
          //     style: Theme.of(context).textTheme.headline3,
          //   ),
          // ),
          // leading: Text(
          //   '${play.player[index].id.toString()}',
          //   style: Theme.of(context).textTheme.headline6,
          // ),
          onTap: () {
            if (arguments[0] == 'player_tile' || arguments[0] == 'matchForm') {
              _selectedItems = [ _nameFirst, _id,_ts];
                  // play.player[index].firstName; // assign first name
              print(_selectedItems);
              Get.back(result: _selectedItems);
            } else {
              print(arguments[0]);
              showBottomSheet(
                _nameFirst,
                _nameLast,
                _wins,
                _id,
                // play.player[index].firstName,
                // play.player[index].lastName,
                // play.player[index].wins,
                // play.player[index].id,
              );
            }
          },
          title: Text(
            '$_nameFirst $_nameLast',
            style: Theme.of(context).textTheme.headline6,
          ),
          trailing: Container(
            alignment: Alignment.center,
            height: 30,
            width: 30,
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).appBarTheme.backgroundColor,
                boxShadow: [
                  BoxShadow(color: Colors.black26, blurRadius: 8.0),
                ]),
            child: Text(
              '${play.player[index].wins.toString()}',
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
        ),
      ),
    );
  }

  Widget header(context) {
    return Card(
      elevation: 6,
      color: Theme.of(context).appBarTheme.backgroundColor,
      child: ListTile(
        // leading: Container(
        //   width: 30,
        //   alignment: Alignment.center,
        //   child: Text('Id', style: Theme.of(context).textTheme.headline5),
        // ),
        title: Text('Name', style: Theme.of(context).textTheme.headline3),
        trailing: Text('Wins', style: Theme.of(context).textTheme.headline3),
      ),
    );
  }

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    //final firstName = Provider.of<PlayerProvider>(context, listen: false).fetchPlayer();
    final play = watch(playerProvider);
    // final fetch = play.fetchPlayer();
    print(play.player.length);
    // return GetX<PlayerController>(
    //   builder: (_) {
    //       // init: PlayerController();
        return ListView.builder(
            // separatorBuilder: (context, index) => Divider(
            //       height: 0,
            //       thickness: 1,
            //       indent: 0,
            //       endIndent: 0,
            //     ),
            itemCount: play.player.length,
            itemBuilder: (contex, index) {
              if (index == 0) {
                return Column(
                  children: [
                    header(context),
                    // Divider(
                    //   height: 0,
                    //   thickness: 4,
                    //   indent: 0,
                    //   endIndent: 0,
                    // ),
                    _listItem(index, play, context)
                  ],
                );
              } else
                return _listItem(index, play, context);
            },);
      // }
      
    // );

  }
}
