import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
// import 'package:file_picker/file_picker.dart';
import 'package:filesystem_picker/filesystem_picker.dart';
import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import '../controllers/providers.dart';
import './custom_widgets/popup_dialog_widgets.dart';

class FunctionHelper {
  static checkWinner({
    required BuildContext context,
    required int player1Score,
    required int player2Score,
    required int player1Id,
    required int player2Id,
    required String player1Name,
    required String player2Name,
    required bool lowScore,
    required int matchId,
  }) {
    String winner = "_";
    int playerId = 1;
    if (lowScore == false && player1Score > player2Score) {
      winner = player1Name;
      playerId = player1Id;
    } else if (lowScore == false && player1Score < player2Score) {
      winner = player2Name;
      playerId = player2Id;
    } else if (lowScore == true && player1Score < player2Score) {
      winner = player1Name;
      playerId = player1Id;
    } else if (lowScore == true && player1Score > player2Score) {
      winner = player2Name;
      playerId = player2Id;
    }
    var _playerIndex = context
        .read(playerProvider)
        .player
        .indexWhere((element) => element.id == playerId);
    final _wins = context.read(playerProvider).player[_playerIndex].wins;
    context.read(matchProvider).updateWinner(
          matchId: matchId,
          winnerName: winner,
          winnerId: playerId,
        );

    // print(
    //     "winner of match $matchId is $winner");

    context.read(playerProvider).plus(
          id: playerId,
          wins: _wins,
          addAmount: 1,
        );
    PopupDialogWidgets.winDialog(context, winner);
  }

  intUtcToStringFormatDT({
    required int dateTimeUtcInt,
    String format = 'yyy-MM-dd',
  }) {
    // Take int and returns date in the default format of YYYY-MM-DD

     DateTime _dts = DateTime.fromMillisecondsSinceEpoch(dateTimeUtcInt);
    String date = DateFormat(format).format(_dts);
    return date;
  }

  dtToStringFormatDT({
    required DateTime dateTimeDt,
    String format = 'yyy-MM-dd',
  }) {
    // Take int and returns date in the default format of YYYY-MM-DD
    // DateTime _dts = DateTime.now();
    String date = DateFormat(format).format(dateTimeDt);
    return date;
  }

  Future<void> exportDb(
    BuildContext context,
  ) async {
    var status = await Permission.storage.status;
    print(status);
    if (status.isDenied) {
      Permission.storage.request();
    }
    final dbPath = await sql.getDatabasesPath();
    final File dbFile = File(path.join(dbPath, 'score.db'));
    // final dirloc = (await getApplicationDocumentsDirectory()).path;
    // final savePath = await _extPath + "/score.db";
    // final dir = Directory('/storage/emulated/0/Download/')
    String? _backupDb = await filePickerFolder(context);
    String _now = dtToStringFormatDT(dateTimeDt: DateTime.now(), format: "yyyyMMddHHmm",) ;
    // String _nowFormat = DateFormat('yyyyMMddHHmm').format(_now);
    print(_now);
    print('This is db dir $dbFile');

    print("$_backupDb/score$_now.db");
    // print(dirloc);
    // share(dbFile);
    // dbFile.copy("$_backupDb/score.db");
    // db.copy(dirloc + "/score.db");
  }

  // Future<void> importDb() async {
  //   // var status = await Permission.storage.status;
  //   // print(status);
  //   // if (status.isDenied ){
  //   //   Permission.storage.request();
  //   // }
  //   final dbPath = await sql.getDatabasesPath();
  //   final String dbFile = path.join(dbPath, 'score.db');
  //   // final dirloc = (await getApplicationDocumentsDirectory()).path;
  //   String file = await _extPath;
  //   final backupPath = File("$file/score.db");
  //   // final dir = Directory('/storage/emulated/0/Download/')
  //   print('This is db dir $dbFile');
  //   print("This is the backup path $backupPath");
  //   // print(dirloc);
  //   // share(dbFile);
  //   backupPath.copy(dbFile);
  //   // db.copy(dirloc + "/score.db");
  // }

  Future<List<Directory>?> _getExternalStoragePath() {
    return getExternalStorageDirectories(type: StorageDirectory.documents);
  }

  Future<void> restore(BuildContext context) async {
    final dbFolder = await sql.getDatabasesPath();
    final dbLocation = path.join(dbFolder, 'score.db');
    // AppDatabase.instance.close();

    String file = await _extPath;
    // final backupPath = File("$file/score.db");

    //acess file backup
    // FilePickerResult? result = await FilePicker.platform.pickFiles(
    //   type: FileType.custom,
    //   allowedExtensions: ["db"],
    // );
    String? backupDb = await filePickerFile(context);
    // String? dbFile = await FilesystemPicker.open(
    //   title: 'Open DB File',
    //   context: context,
    //   rootDirectory: Directory("storage"),
    //   fsType: FilesystemType.file,
    //   allowedExtensions: [".db"],
    //   pickText: 'Open file to this folder',
    //   folderIconColor: Colors.teal,
    // );
    print(backupDb);
    print(file);
    if (backupDb != null) {
      Uint8List updatedContent = await File(backupDb).readAsBytes();
      File(dbLocation).writeAsBytes(updatedContent);
    }
    // // File resultFile = File(result.files.first.path);
    // Uint8List updatedContent = await File("$file/score.db").readAsBytes();
    // File(dbLocation).writeAsBytes(updatedContent);
  }

  Future<String?> filePickerFile(
    BuildContext context,
  ) async {
    String? _dbFile = await FilesystemPicker.open(
      title: 'Select DB File',
      context: context,
      rootDirectory: Directory("storage"),
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
      rootDirectory: Directory("storage"),
      fsType: FilesystemType.folder,
      allowedExtensions: [".db"],
      pickText: 'Select Folder For Backup ',
      folderIconColor: Theme.of(context).appBarTheme.backgroundColor,
    );
    return _dbFile;
  }

  void share(File file) async {
    // File file = await _localFile; // 1
    Share.shareFiles([file.path], text: 'Database Backup'); // 2
  }

  Future<String> get _extPath async {
    var extPath = await getExternalStorageDirectory();
    if (extPath == null) {
      extPath = Directory("This");
      return extPath.path;
    } else {
      return extPath.path;
    }
  }

  // Future<File> get _localFile async {
  //   final path = await _extPath;
  //   return File('$path/score.db');
  // }
  // void updateSelected({
  //   required int id,
  //   required bool isSelected,
  //   required String type,
  // }) {
  //   isSelected = !isSelected;
  //   int isSelectedInt = isSelected == false ? 0 : 1;
  //   // return isSelectedInt;
  //   // notifyListeners();
  // }
}
