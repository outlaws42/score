import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:async';
import 'dart:io';
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
    // required bool lowScore,
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
      _random.nextInt(256),
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

  Future<String> backupDb(
      {required BuildContext context,
      String fileName = 'score',
      String fileExt = 'db'}) async {
    var status = await Permission.storage.status;
    if (status.isDenied) {
      Permission.storage.request();
    }
    final dbPath = await sql.getDatabasesPath();
    final File dbFile = File(path.join(dbPath, '$fileName.$fileExt'));
    String _now = dtToStringFormatDT(
      dateTimeDt: DateTime.now(),
      format: "yyyyMMddHHmmss",
    );
    String sdCard = await getExternalSdCardPath();
    String saveFile = sdCard + "/$fileName$_now.$fileExt";
    dbFile.copy(saveFile);
    return saveFile;
  }

  Future<String> getExternalSdCardPath() async {
    // Requires: path_provider
    // Returns the external app Dir if it exists.
    // If not it returns the internal app dir
    List<Directory>? extDirectories = await getExternalStorageDirectories();
    String rebuiltPath = "";
    List<String> dirs = [];
    if (extDirectories != null && extDirectories.asMap().containsKey(1)) {
      dirs = extDirectories[1].toString().split("/");
    } else {
      dirs = extDirectories![0].toString().split("/");
    }
    for (int i = 1; i < dirs.length; i++) {
      rebuiltPath = rebuiltPath + "/" + dirs[i];
    }
    if (rebuiltPath.length > 0) {
      rebuiltPath = rebuiltPath.substring(0, rebuiltPath.length - 1);
    }
    return rebuiltPath;
  }

  Future<void> shareDb({
    required BuildContext context,
    String fileName = "score",
    String fileExt = 'db',
  }) async {
    // Requires: path' as path, permission_handler, sqflite.dart' as sql
    // Requires: The internal function share.
    // Gets Db file and calls the share function
    // Allows the user to share through the OS share options.
    var status = await Permission.storage.status;
    if (status.isDenied) {
      Permission.storage.request();
    }
    final _filePath = await sql.getDatabasesPath();
    final File _file = File(path.join(_filePath, "$fileName.$fileExt"));
    share(
      file: _file,
    );
  }

  void share({
    required File file,
    String text = 'Database Backup',
  }) async {
    // Requires: share_plus
    // Takes a file to share the uses the OS share options
    Share.shareFiles([file.path], text: text);
  }

  // Future<void> restore({
  //   required BuildContext context,
  //   String fileName = 'score.db',
  // }) async {
  //   final dbFolder = await sql.getDatabasesPath();
  //   final dbLocation = path.join(dbFolder, fileName);
  //   String? backupDb = await filePickerFile(context);
  //   if (backupDb != null) {
  //     Uint8List updatedContent = await File(backupDb).readAsBytes();
  //     File(dbLocation).writeAsBytes(updatedContent);
  //   }
  // }

  // Future<String?> filePickerFile(
  //   BuildContext context,
  // ) async {
  //   String sdCard = await getExternalSdCardPath();
  //   String? _dbFile = await FilesystemPicker.open(
  //     title: 'Select DB File',
  //     context: context,
  //     rootDirectory: Directory(sdCard),
  //     fsType: FilesystemType.file,
  //     allowedExtensions: [".db"],
  //     pickText: 'Select File ',
  //     folderIconColor: Theme.of(context).appBarTheme.backgroundColor,
  //   );
  //   return _dbFile;
  // }

  // Future<String?> filePickerFolder(
  //   BuildContext context,
  // ) async {
  //   String? _dbFile = await FilesystemPicker.open(
  //     title: 'Select Database Backup Location',
  //     context: context,
  //     rootDirectory: Directory("android"),
  //     fsType: FilesystemType.folder,
  //     allowedExtensions: [".db"],
  //     pickText: 'Select Folder For Backup ',
  //     folderIconColor: Theme.of(context).appBarTheme.backgroundColor,
  //   );
  //   return _dbFile;
  // }

  static removePref(key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  static license() async {
    Uri _url = Uri.parse(licenseUrl);
    if (!await launchUrl(
      _url,
      // forceWebView: true,
      // enableJavaScript: true,
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
