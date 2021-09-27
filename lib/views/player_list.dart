import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:flutter/widgets.dart';
import '../controllers/providers.dart';


class PlayerList extends ConsumerWidget {
  
  showBottomSheet(name, wins, id, status) {
    Get.bottomSheet(
      Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: ListView.builder(
            itemCount: status.matchWins.length,
            itemBuilder: (context, index) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("${status.matchWins[index].player1Name} vs ${status.matchWins[index].player2Name}"),
                  Text("${status.matchWins[index].gameName}"),
                  // Text("$wins"),
                ],
              );
            }
          ),
        ),
      ),
    );
  }

  void playerAcomplishments(){

  }

  Widget _listItem(index, play, BuildContext context,status) {
    List _selectedItems = [];
    List arguments = Get.arguments;
    final _name = play.player[index].name;
    // final _nameLast = play.player[index].lastName;
    final _wins = play.player[index].wins;
    final _id = play.player[index].id;
    // final _ts = play.player[index].tempScore;
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
              _selectedItems = [ _name, _id];
                  // play.player[index].firstName; // assign first name
              print(_selectedItems);
              Get.back(result: _selectedItems);
            } else {
              print(arguments[0]);
              // context.read(matchProvider).fetchMatchByWinnerId(winnerId: _id);
              showBottomSheet(
                _name,
                _wins,
                _id,
                status,
                // play.player[index].firstName,
                // play.player[index].lastName,
                // play.player[index].wins,
                // play.player[index].id,
              );
            }
          },
          title: Text(
            '$_name',
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
    DateTime dt = DateTime.now();
    int ms = dt.toUtc().millisecondsSinceEpoch;
    // double unix = ms/1000;
    print(dt);
    print(ms);
    // print(unix);
    DateTime dts = DateTime.fromMillisecondsSinceEpoch(ms);
    print(dts);
    print(dt);
    // final DateFormat formatter =DateFormat('yyyy-MM-dd');
    final play = watch(playerProvider);
    final _status = watch(matchProvider);
    // context.read(matchProvider).fetchMatchByWinnerId(winnerId: 2);
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
                    _listItem(index, play, context, _status)
                  ],
                );
              } else
                return _listItem(index, play, context, _status);
            },);
      // }
      
    // );

  }
}
