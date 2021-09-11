import 'package:flutter_riverpod/flutter_riverpod.dart';
import './game_provider.dart';
import './player_provider.dart';
import './match.dart';

final gameProvider = ChangeNotifierProvider<GameProvider>((ref) => GameProvider());
final playerProvider = ChangeNotifierProvider<PlayerProvider>((ref) => PlayerProvider());
final matchProvider = ChangeNotifierProvider<MatchProvider>((ref) => MatchProvider());