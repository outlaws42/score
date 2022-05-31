import 'package:flutter_riverpod/flutter_riverpod.dart';
import './game_provider.dart';
import './player_provider.dart';
import './match_provider.dart';
import './auth_provider.dart';

final gameProvider = ChangeNotifierProvider<GameProvider>((ref) => GameProvider());
final playerProvider = ChangeNotifierProvider<PlayerProvider>((ref) => PlayerProvider());
final matchProvider = ChangeNotifierProvider<MatchProvider>((ref) => MatchProvider());
final authProvider = ChangeNotifierProvider<AuthProvider>((ref) => AuthProvider());