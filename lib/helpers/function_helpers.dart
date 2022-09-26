import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';
import '../controllers/providers.dart';
import '../helpers.dart';

class FunctionHelper {
  static checkWinner({
    required WidgetRef ref,
    required BuildContext context,
    required bool lowScore,
    required String matchId,
    required int matchIndex,
  }) {
    var _players = ref.read(matchProvider).match[matchIndex].players;
    int _winScore = 0;

    _winScore = checkWinningScore(
      ref: ref,
      lowScore: lowScore,
      context: context,
      index: matchIndex,
    );

    addPlayerMatch(
      ref: ref,
      context: context,
      index: matchIndex,
    );

    var _matchPlayerIndex =
        _players.indexWhere((element) => element.score == _winScore);
    String _winner = _players[_matchPlayerIndex].playerName;
    String _playerId = _players[_matchPlayerIndex].playerId;

    var _playerIndex = ref
        .read(playerProvider)
        .player
        .indexWhere((element) => element.id == _playerId);
    final _wins = ref.read(playerProvider).player[_playerIndex].wins;
    ref.read(matchProvider).updateWinner(
          matchId: matchId,
          winnerName: _winner,
          winnerId: _playerId,
        );

    int _totalWins = ref.read(playerProvider).add(
          number: _wins,
          addAmount: 1,
        );
    ref.read(playerProvider).updatePlayerWins(
          _playerId,
          _playerIndex,
          _totalWins,
        );
    PopupDialogWidgets.winDialog(
      context,
      _winner,
    );
  }

  static checkWinningScore({
    required WidgetRef ref,
    required BuildContext context,
    required bool lowScore,
    required int index,
  }) {
    // Checks the players score in the list to see wich one
    // is highest or lowest depending on  whether the game
    // is a low score or high score game.
    // returns the winning score.

    final _players = ref.read(matchProvider).match[index].players;
    int _winScore;

    if (lowScore == true) {
      _winScore = _players.map((abc) => abc.score).reduce(min);
    } else {
      _winScore = _players.map((abc) => abc.score).reduce(max);
    }
    return _winScore;
  }

  static addPlayerMatch({
    required WidgetRef ref,
    required BuildContext context,
    required int index,
  }) {
    // Add the amount of player matches

    final _players = ref.read(matchProvider).match[index].players;
    for (var eachplayer in _players) {
      var _playerId = eachplayer.playerId;
      var _playerIndex = ref
          .read(playerProvider)
          .player
          .indexWhere((element) => element.id == _playerId);
      final _matches = ref.read(playerProvider).player[_playerIndex].matches;
      final _totalMatches = ref.read(playerProvider).add(
            number: _matches,
            addAmount: 1,
          );
      ref.read(playerProvider).updatePlayerMatches(
            _playerId,
            _playerIndex,
            _totalMatches,
          );
    }
  }

  static checkWinningScoreDuplicate({
    required WidgetRef ref,
    required BuildContext context,
    required int index,
    required int winScore,
  }) {
    // Takes the winning score
    // Check and see if more than one player has the winning score
    // returns a false if the winning score  is in our list more than once

    final _players = ref.read(matchProvider).match[index].players;
    bool _scoreCheck = false;

    final _winScoreTimes =
        _players.where((element) => element.score == winScore);
    if (_winScoreTimes.length > 1) {
      _scoreCheck = false;
    } else {
      _scoreCheck = true;
    }
    return _scoreCheck;
  }

  static randomColor() {
    // Create integer random color
    final _random = Random();
    final randomColor = Color.fromARGB(
      255,
      _random.nextInt(256),
      _random.nextInt(256),
      _random.nextInt(256),
    );
    return randomColor;
  }

  static convertColorInt({required Color color}) {
    // Takes a color and returns a integer color.
    String colorString = color.toString();
    String valueString = colorString.split('(0x')[1].split(')')[0];
    int value = int.parse(valueString, radix: 16);
    return value;
  }

  intUtcToStringFormatDT({
    required int dateTimeUtcInt,
    String format = 'yyy-MM-dd',
  }) {
    // requires
    // import 'package:intl/intl.dart';
    DateTime _dateTime =
        DateTime.fromMillisecondsSinceEpoch(dateTimeUtcInt * 1000);
    DateTime _dateTimeLocal = DateFormat("yyyy-MM-dd HH:mm:ss")
        .parse(_dateTime.toString(), true)
        .toLocal();
    String formatDt = DateFormat(format).format(_dateTimeLocal);
    return formatDt;
  }

  dtToStringFormatDT({
    required DateTime dateTimeDt,
    String format = 'yyy-MM-dd',
  }) {
    // requires
    // import 'package:intl/intl.dart';
    String formatDt = DateFormat(format).format(dateTimeDt);
    return formatDt;
  }

  static removePref(key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  static license() async {
    Uri _url = Uri.parse(licenseUrl);
    if (!await launchUrl(
      _url,
    )) throw 'Could not launch $_url';
  }

  static sourceCode() async {
    Uri _url = Uri.parse(sourcCodeUrl);
    if (!await launchUrl(
      _url,
      mode: LaunchMode.externalApplication,
    )) throw 'Could not launch $_url';
  }

  static gameDescription(String url) async {
    Uri _url = Uri.parse(url);
    if (!await launchUrl(
      _url,
      mode: LaunchMode.externalApplication,
    )) throw 'Could not launch $_url';
  }
}
