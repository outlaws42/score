import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:score/controllers/providers.dart';
import 'package:score/views/match_form.dart';
// import 'package:provider/provider.dart';

import './controllers/theme_provider.dart';
// import './controllers/settings_provider.dart';
// import './controllers/player_provider.dart';
// import './controllers/game_provider.dart';
import './helpers/theme_config.dart';
import './views/main_screen.dart';
import './views/match_screen.dart';
import './views/settings.dart';
import './views/player_screen.dart';
import './views/game_screen.dart';
import './views/team_screen.dart';
import './views/match_current_screen.dart';
import './views/match_form.dart';
import './views/game_form.dart';
import './views/player_form.dart';

void main() {
  runApp(
    ProviderScope(
      // providers: [
      //   ChangeNotifierProvider<ThemeProvider>(
      //     create: (ctx) => ThemeProvider(),
      //   ),
      //   ChangeNotifierProvider<SettingsProvider>(
      //     create: (ctx) => SettingsProvider(),
      //   ),
      // ChangeNotifierProvider<PlayerProvider>(
      //   create: (ctx) => PlayerProvider(),
      // ),
      // ChangeNotifierProvider<GameProvider>(
      //   create: (ctx) => GameProvider(),
      // ),
      // ],
      child: MyApp(),
    ),
  );
}

final themeProvider = ChangeNotifierProvider((ref) => ThemeProvider());

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final appState = watch(themeProvider);
    context.read(matchProvider).fetchMatch();
    context.read(playerProvider).fetchPlayer();
    context.read(gameProvider).fetchGame();
    print("Fetch all state when first load");
    // return Consumer<ThemeProvider>(
    //   builder: (context, appState, child) {
    return GetMaterialApp(
      title: 'Scoreboard',
      debugShowCheckedModeBanner: false,
      theme: ThemeConfig.lightTheme,
      darkTheme: ThemeConfig.darkTheme,
      home: MatchScreen(),
      themeMode: appState.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      getPages: [
        GetPage(name: '/', page: () => MainScreen()),
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
      //  routes: {
      //    Settings.routeName: (ctx) => Settings(),
      //    PlayersScreen.routeName: (ctx) => PlayersScreen(),
      //    GameScreen.routeName: (ctx) => GameScreen(),
      //    TeamScreen.routeName: (ctx) => TeamScreen(),

      //               },
    );
    // },
    // );
  }
}
