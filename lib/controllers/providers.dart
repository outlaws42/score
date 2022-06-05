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

//Get access to the state of another provider. 
// Passing the API token from the authProvider to the MatchProvider
final matchProvider = ChangeNotifierProvider<MatchProvider>((ref)  {
  final _token = ref.watch(authProvider).token;
  return MatchProvider(_token.toString());
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