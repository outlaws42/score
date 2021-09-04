import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/widgets.dart';
import '../controllers/player_controller.dart';

class PlayerList extends StatelessWidget {
  final PlayerController playerController = Get.find();

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
    String? _selectedItems;
    var title = Get.arguments;
    print(title);
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
            if (title[0] == 'main_body') {
              _selectedItems =
                  play.players[index].firstName; // assign first name
              print(_selectedItems);
              Get.back(result: _selectedItems);
            } else {
              print(title[0]);
              showBottomSheet(
                play.players[index].firstName,
                play.players[index].lastName,
                play.players[index].wins,
                play.players[index].id,
              );
            }
          },
          title: Text(
            '${play.players[index].firstName.toString()} ${play.players[index].lastName.toString()}',
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
              '${play.players[index].wins.toString()}',
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
  Widget build(BuildContext context) {
    //final firstName = Provider.of<PlayerProvider>(context, listen: false).fetchPlayer();

    return GetX<PlayerController>(
      builder: (_) {
          // init: PlayerController();
        return ListView.builder(
            // separatorBuilder: (context, index) => Divider(
            //       height: 0,
            //       thickness: 1,
            //       indent: 0,
            //       endIndent: 0,
            //     ),
            itemCount: _.players.length,
            itemBuilder: (ctx, index) {
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
                    _listItem(index, _, context)
                  ],
                );
              } else
                return _listItem(index, _, context);
            });
      }
      
    );
    
  }
}
