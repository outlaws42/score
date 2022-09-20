import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import './views/splash_screen.dart';
import './controllers/providers.dart';
import './helpers/theme_config.dart';
import './views/settings.dart';
import './views/player_select_screen.dart';
import './views/spinner_form.dart';
import './views/match_current_screen_list.dart';
import './views/match_form.dart';
import './views/game_form.dart';
import './views/player_form.dart';
import './views/auth_screen.dart';
import './views/tab_bar_screen.dart';
import 'views/game_select_screen.dart';
import './controllers/init_global_providers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initGlobalProviders();
  // SharedPreferences prefs = await SharedPreferences.getInstance();

  // Temp for dev to overide signed certs. Remove for production
  HttpOverrides.global = new DevHttpOverrides();

  runApp(
    ProviderScope(
      //   overrides: [
      //   sharedPreferencesProvider.overrideWithValue(prefs),
      // ],
      child: MyApp(),
    ),
  );
}

class DevHttpOverrides extends HttpOverrides {
  // Temp for dev to overife signed certs. Remove fo production
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      // ref.watch(appThemeProvider).intialize();
      final _authSwitch = ref.watch(authProvider).isAuth;
      if (_authSwitch == true) {
        ref.read(playerProvider).fetchPlayer();
      }

      return GetMaterialApp(
        title: 'Scoreboard',
        debugShowCheckedModeBanner: false,
        theme: ThemeConfig.lightTheme,
        darkTheme: ThemeConfig.darkTheme,
        themeMode: ref.watch(appThemeProvider).themeMode,
        home: _authSwitch == true
            ? TabBarScreen()
            : FutureBuilder(
                future: ref.watch(authProvider).tryAutoLogin(),
                builder: (
                  ctx,
                  authResultSnapshot,
                ) =>
                    authResultSnapshot.connectionState ==
                            ConnectionState.waiting
                        ? SplashScreen()
                        : AuthScreen(),
              ),
        getPages: [
          GetPage(name: '/match', page: () => TabBarScreen()),
          GetPage(name: '/game_select', page: () => GameSelectScreen()),
          GetPage(name: '/match_current', page: () => MatchCurrentScreenList()),
          GetPage(name: '/players_select', page: () => PlayersSelectScreen()),
          GetPage(name: '/spinner_form', page: () => SpinnerForm()),
          GetPage(name: '/match_form', page: () => MatchForm()),
          GetPage(name: '/game_form', page: () => GameForm()),
          GetPage(name: '/player_form', page: () => PlayerForm()),
          GetPage(name: '/settings', page: () => Settings()),
          GetPage(name: '/auth', page: () => AuthScreen()),
        ],
      );
    });
  }
}
