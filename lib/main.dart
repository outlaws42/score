import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:score/controllers/providers.dart';
import 'package:score/views/match_form.dart';
import './helpers/theme_config.dart';
import './views/match_screen.dart';
import './views/settings.dart';
import './views/player_screen.dart';
import './views/game_screen.dart';
import './views/team_screen.dart';
import './views/match_current_screen.dart';
import './views/match_form.dart';
import './views/game_form.dart';
import 'views/player_form.dart';

void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    context.read(matchProvider).fetchMatch();
    context.read(playerProvider).fetchPlayer();
    context.read(gameProvider).fetchGame();
    return GetMaterialApp(
      title: 'Scoreboard',
      debugShowCheckedModeBanner: false,
      theme: ThemeConfig.lightTheme,
      darkTheme: ThemeConfig.darkTheme,
      home: MatchScreen(),
      themeMode: ThemeMode.light,
      getPages: [
        GetPage(name: '/match', page: () => MatchScreen()),
        GetPage(name: '/match_current', page: () => MatchCurrentScreen()),
        GetPage(name: '/games', page: () => GameScreen()),
        GetPage(name: '/players', page: () => PlayersScreen()),
        GetPage(name: '/teams', page: () => TeamScreen()),
        GetPage(name: '/match_form', page: () => MatchForm()),
        GetPage(name: '/game_form', page: () => GameForm()),
        GetPage(name: '/player_form', page: () => PlayerForm()),
        GetPage(name: '/settings', page: () => Settings()),
      ],
    );
  }
}
