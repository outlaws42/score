import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:score/controllers/settings_provider.dart';
import './game_provider.dart';
import './player_provider.dart';
import './match_provider.dart';
import './auth_provider.dart';
import 'app_theme_provider.dart';
import './init_global_providers.dart';

final authProvider = ChangeNotifierProvider<AuthProvider>((ref) => AuthProvider()
);

// final sharedPreferencesProvider = Provider<SharedPreferences>((_) {
//   return throw UnimplementedError();
// });

final appThemeProvider = ChangeNotifierProvider((ref) => AppThemeProvider(ref.watch(sharedPreferences)));

// final appThemeProvider = ChangeNotifierProvider((ref) {
//   return AppThemeProvider(ref.watch(sharedPreferencesProvider));
// });

final settingsProvider = ChangeNotifierProvider<SettingsProvider>((ref) => SettingsProvider());

//Get access to the state of another provider.
// Passing the API token from the authProvider to the MatchProvider
final matchProvider = ChangeNotifierProvider<MatchProvider>((ref) {
  final _token = ref.watch(authProvider).token;
  return MatchProvider(
    _token.toString(),
  );
});

final gameProvider = ChangeNotifierProvider<GameProvider>((ref) {
  final _token = ref.watch(authProvider).token;
  return GameProvider(
    _token.toString(),
  );
});

final playerProvider = ChangeNotifierProvider<PlayerProvider>((ref) {
  final _token = ref.watch(authProvider).token;
  return PlayerProvider(
    _token.toString(),
  );
});
