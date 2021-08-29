import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './providers/theme_provider.dart';
import './providers/settings_provider.dart';
import './providers/player_provider.dart';
import './providers/game_provider.dart';
import './helpers/theme_config.dart';
import './screens/main_screen.dart';
import 'screens/settings.dart';
import 'screens/player_screen.dart';
import 'screens/game_screen.dart';
import 'screens/team_screen.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<ThemeProvider>(
        create: (ctx) => ThemeProvider(),
      ),
      ChangeNotifierProvider<SettingsProvider>(
        create: (ctx) => SettingsProvider(),
      ),
      ChangeNotifierProvider<PlayerProvider>(
        create: (ctx) => PlayerProvider(),
      ),
      ChangeNotifierProvider<GameProvider>(
        create: (ctx) => GameProvider(),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, appState, child) {
        return MaterialApp(
          title: 'Scoreboard',
          debugShowCheckedModeBanner: false,
          theme: ThemeConfig.lightTheme,
          darkTheme: ThemeConfig.darkTheme,
          home: MainScreen(),
          themeMode: appState.isDarkMode ? ThemeMode.dark : ThemeMode.light,
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
