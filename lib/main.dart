import 'dart:io';
import 'package:http/io_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:score/controllers/auth_provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import './controllers/providers.dart';
import './helpers/theme_config.dart';
import './views/match_screen.dart';
import './views/settings.dart';
import './views/player_screen.dart';
import './views/player_select_screen.dart';
import './views/game_screen.dart';
import './views/team_screen.dart';
import './views/match_current_screen_list.dart';
import './views/match_form.dart';
import './views/game_form.dart';
import 'views/player_form.dart';
import 'views/auth_screen.dart';

void main() async{
  // Temp for dev to overide signed certs. Remove for production
  HttpOverrides.global = new DevHttpOverrides();

  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class DevHttpOverrides extends HttpOverrides {
  // Temp for dev to overife signed certs. Remove fo production
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context,) {
    // context.read(matchProvider).fetchMatch();
    // context.read(playerProvider).fetchPlayer();
    // context.read(gameProvider).fetchGame();
    // final auth = context.read(authProvider).isAuth;
    // print('This is main auth: $auth');
    return Consumer(
      builder: (context, auth, _) {
        final _authSwitch = auth(authProvider).isAuth; 
        print('This is main authSwitch: $_authSwitch');
        context.read(matchProvider).fetchMatch();
        context.read(gameProvider).fetchGame();
        context.read(playerProvider).fetchPlayer();
        return GetMaterialApp(
          title: 'Scoreboard',
          debugShowCheckedModeBanner: false,
          theme: ThemeConfig.lightTheme,
          darkTheme: ThemeConfig.darkTheme,
          home: _authSwitch == true ? MatchScreen() : AuthScreen(),
          themeMode: ThemeMode.light,
          getPages: [
            GetPage(name: '/match', page: () => MatchScreen()),
            GetPage(name: '/match_current', page: () => MatchCurrentScreenList()),
            GetPage(name: '/games', page: () => GameScreen()),
            GetPage(name: '/players', page: () => PlayersScreen()),
            GetPage(name: '/players_select', page: () => PlayersSelectScreen()),
            GetPage(name: '/teams', page: () => TeamScreen()),
            GetPage(name: '/match_form', page: () => MatchForm()),
            GetPage(name: '/game_form', page: () => GameForm()),
            GetPage(name: '/player_form', page: () => PlayerForm()),
            GetPage(name: '/settings', page: () => Settings()),
          ],
        );
      }
    );
  }
}
