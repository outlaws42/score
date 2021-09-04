import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import './controllers/theme_provider.dart';
import './controllers/settings_provider.dart';
// import './controllers/player_provider.dart';
// import './controllers/game_provider.dart';
import './helpers/theme_config.dart';
import './views/main_screen.dart';
import './views/settings.dart';
import './views/player_screen.dart';
import './views/game_screen.dart';
import './views/team_screen.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<ThemeProvider>(
        create: (ctx) => ThemeProvider(),
      ),
      ChangeNotifierProvider<SettingsProvider>(
        create: (ctx) => SettingsProvider(),
      ),
      // ChangeNotifierProvider<PlayerProvider>(
      //   create: (ctx) => PlayerProvider(),
      // ),
      // ChangeNotifierProvider<GameProvider>(
      //   create: (ctx) => GameProvider(),
      // ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, appState, child) {
        return GetMaterialApp(
          title: 'Scoreboard',
          debugShowCheckedModeBanner: false,
          theme: ThemeConfig.lightTheme,
          darkTheme: ThemeConfig.darkTheme,
          home: MainScreen(),
          themeMode: appState.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          getPages: [
            GetPage(name: '/', page: () => MainScreen()),
            GetPage(name: '/games', page: () => GameScreen()),
            GetPage(name: '/players', page: () => PlayersScreen()),
            GetPage(name: '/teams', page: () => TeamScreen()), 
            GetPage(name: '/settings', page: () => Settings()),
          ],
           routes: {
             Settings.routeName: (ctx) => Settings(),
             PlayersScreen.routeName: (ctx) => PlayersScreen(),
             GameScreen.routeName: (ctx) => GameScreen(),
             TeamScreen.routeName: (ctx) => TeamScreen(),

                        },
        );
      },
    );
  }
}
