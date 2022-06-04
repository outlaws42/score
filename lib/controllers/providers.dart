import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/match_model.dart';
import './game_provider.dart';
import './player_provider.dart';
import './match_provider.dart';
import './auth_provider.dart';

// final gameProvider = ChangeNotifierProvider<GameProvider>((ref) => GameProvider());
// final playerProvider = ChangeNotifierProvider<PlayerProvider>((ref) => PlayerProvider());
// final matchProvider = ChangeNotifierProvider<MatchProvider>((ref) => MatchProvider());
final authProvider = ChangeNotifierProvider<AuthProvider>((ref) => AuthProvider());

final matchProvider = ChangeNotifierProvider<MatchProvider>((ref)  {
  final tokent = ref.watch(authProvider).token;
  return MatchProvider(tokent.toString());
});

final gameProvider = ChangeNotifierProvider<GameProvider>((ref)  {
  final _token = ref.watch(authProvider).token;
  return GameProvider(_token.toString());
});

final playerProvider = ChangeNotifierProvider<PlayerProvider>((ref)  {
  final _token = ref.watch(authProvider).token;
  return PlayerProvider(_token.toString());
});

// final authProvider = ChangeNotifierProvider<AuthProvider>((ref) => AuthProvider());

// final matchProvider = ChangeNotifierProvider<MatchModel>((ref) {
//   final model = MatchModel;
//   ref.listen<Value>()
//    MatchProvider()});