import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:filesystem_picker/filesystem_picker.dart';
import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import '../controllers/providers.dart';
import './custom_widgets/popup_dialog_widgets.dart';

class FunctionHelper {
  static checkWinner({
    required BuildContext context,
    // required int player1Score,
    // required int player2Score,
    // required String player1Id,
    // required String player2Id,
    // required String player1Name,
    // required String player2Name,
    required bool lowScore,
    required String matchId,
  }) {

    var _match = context.read(matchProvider).match;
    print('This is the lowScore: $lowScore');
    var _matchIndex = _match.indexWhere((element) => element.id == matchId);
    var _players = _match[_matchIndex].players;

    int _winScore= 0;
    if (lowScore == true) {
      _winScore = _players.map((abc) => abc.score).reduce(min);
    } else {
      _winScore = _players.map((abc) => abc.score).reduce(max);
    }

    // print('This is the winScore: $_winScore');
    var _matchPlayerIndex = _players.indexWhere((element) => element.score == _winScore);
    String _winner = _players[_matchPlayerIndex].playerName;
    String _playerId = _players[_matchPlayerIndex].playerId;
    // print('This is the winner: $_winner');
    // print('This is the winners Id: $_playerId');
    for (var i in _match[_matchIndex].players) print(i.score);

    // String winner = "_";
    // String playerId = "_";
    // if (lowScore == false && player1Score > player2Score) {
    //   winner = player1Name;
    //   playerId = player1Id;
    // } else if (lowScore == false && player1Score < player2Score) {
    //   winner = player2Name;
    //   playerId = player2Id;
    // } else if (lowScore == true && player1Score < player2Score) {
    //   winner = player1Name;
    //   playerId = player1Id;
    // } else if (lowScore == true && player1Score > player2Score) {
    //   winner = player2Name;
    //   playerId = player2Id;
    // }
    var _playerIndex = context
        .read(playerProvider)
        .player
        .indexWhere((element) => element.id == _playerId);
    final _wins = context.read(playerProvider).player[_playerIndex].wins;
    context.read(matchProvider).updateWinner(
          matchId: matchId,
          winnerName: _winner,
          winnerId: _playerId,
        );

    context.read(playerProvider).plus(
          id: _playerId,
          wins: _wins,
          addAmount: 1,
        );
    PopupDialogWidgets.winDialog(
      context,
      _winner,
    );
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

  Future<void> restore({
    required BuildContext context,
    String fileName = 'score.db',
  }) async {
    final dbFolder = await sql.getDatabasesPath();
    final dbLocation = path.join(dbFolder, fileName);
    String? backupDb = await filePickerFile(context);
    if (backupDb != null) {
      Uint8List updatedContent = await File(backupDb).readAsBytes();
      File(dbLocation).writeAsBytes(updatedContent);
    }
  }

  Future<String?> filePickerFile(
    BuildContext context,
  ) async {
    String sdCard = await getExternalSdCardPath();
    String? _dbFile = await FilesystemPicker.open(
      title: 'Select DB File',
      context: context,
      rootDirectory: Directory(sdCard),
      fsType: FilesystemType.file,
      allowedExtensions: [".db"],
      pickText: 'Select File ',
      folderIconColor: Theme.of(context).appBarTheme.backgroundColor,
    );
    return _dbFile;
  }

  Future<String?> filePickerFolder(
    BuildContext context,
  ) async {
    String? _dbFile = await FilesystemPicker.open(
      title: 'Select Database Backup Location',
      context: context,
      rootDirectory: Directory("android"),
      fsType: FilesystemType.folder,
      allowedExtensions: [".db"],
      pickText: 'Select Folder For Backup ',
      folderIconColor: Theme.of(context).appBarTheme.backgroundColor,
    );
    return _dbFile;
  }

  static license() async {
    const url = 'https://www.gnu.org/licenses/old-licenses/gpl-2.0.txt';
    await launch(
      url,
      forceWebView: true,
      enableJavaScript: true,
    );
  }
}
