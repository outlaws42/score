import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/player_provider.dart';

class MainBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final firstName = Provider.of<PlayerProvider>(context, listen: false).fetchPlayer();

    return FutureBuilder(
      future: Provider.of<PlayerProvider>(context, listen: false).fetchPlayer(),
      builder: (ctx, snapshot) =>
          snapshot.connectionState == ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Consumer<PlayerProvider>(
                  builder: (cont, play, ch) => ListView.separated(
                    separatorBuilder:(context, index) => Divider(
                        height: 20,
                        thickness: 5,
                        indent: 0,
                        endIndent: 0,
                      ), 
                    itemCount: play.player.length,
                    itemBuilder: (ctx, index) => ListTile(
                      leading: Text(
                        '${play.player[index].id.toString()}',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      title: Text(
                        '${play.player[index].firstName.toString()} ${play.player[index].lastName.toString()}',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      trailing: Text(
                        '${play.player[index].wins.toString()}',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    
                  ),
                ),
    );
  }
}
