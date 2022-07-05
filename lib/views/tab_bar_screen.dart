import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
// import 'package:get/get.dart';
import './game_list.dart';
// import 'package:score/views/game_screen.dart';
// import 'package:score/views/match_screen.dart';
import './player_list.dart';
import './settings.dart';
// import 'package:score/views/player_screen.dart';
import './match_list.dart';
import '../helpers.dart';

class TabBarScreen extends StatefulWidget {
  @override
  State<TabBarScreen> createState() => _TabBarScreenState();
}

class _TabBarScreenState extends State<TabBarScreen> {
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> _pages = [
      {
        'page': MatchList(),
        'title': 'Matches',
        'actions': [
          PageWidgets().iconButtonBarDocs(
            context: context,
            data: "assets/help_match.md",
            icon: Icon(MdiIcons.help),
            iconSize: 25,
          ),
          PageWidgets().iconButtonBar(
            context: context,
            pageLink: "/match_form",
            icon: Icon(Icons.post_add),
          ),
        ],
      },
      {
        'page': PlayerList(),
        'title': 'Players',
        'actions': [
           PageWidgets().iconButtonBarDocs(
            context: context,
            data: "assets/help_player.md",
            icon: Icon(MdiIcons.help),
            iconSize: 25,
          ),
          PageWidgets().iconButtonBar(
            context: context,
            pageLink: "/player_form",
            icon: Icon(Icons.person_add),
          ),
        ]
      },
      {
        'page': GameList(),
        'title': 'Games',
        'actions': [
          PageWidgets().iconButtonBarDocs(
            context: context,
            data: "assets/help_game.md",
            icon: Icon(MdiIcons.help),
            iconSize: 25,
          ),
          PageWidgets().iconButtonBar(
            context: context,
            pageLink: "/game_form",
            icon: Icon(Icons.add_box),
          ),
        ]
      },
      {
        'page': Settings(),
        'title': 'Settings',
        'actions': [
          PageWidgets().iconButtonBarDocs(
            context: context,
            data: "assets/help_settings.md",
            icon: Icon(MdiIcons.help),
            iconSize: 25,
          ),
          // PageWidgets().iconButtonBar(
          //   context: context,
          //   pageLink: "/game_form",
          //   icon: Icon(Icons.add_box),
          // ),
        ]
      },
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${_pages[_selectedPageIndex]['title']}',
          style: Theme.of(context).textTheme.headline3,
        ),
        actions: _pages[_selectedPageIndex]['actions'],
      ),
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.list_alt,
            ),
            label: 'Matches',
            // activeIcon: Icon(Icons.abc),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Players',
            // activeIcon: Icon(Icons.abc),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.gamepad),
            label: 'Games',
            // activeIcon: Icon(Icons.abc),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
            // activeIcon: Icon(Icons.abc),
          ),
        ],
        backgroundColor: Theme.of(context).appBarTheme.foregroundColor,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Theme.of(context).colorScheme.secondaryContainer,
        type: BottomNavigationBarType.fixed,
        elevation: 30,
        currentIndex: _selectedPageIndex,
      ),
    );
  }
}
