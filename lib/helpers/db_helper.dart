import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper {
  static Future<sql.Database> database() async {
    // Get the Database path
    final dbPath = await sql.getDatabasesPath();
    // Path of the db and the db name, onCreate is done only when creating the
    // db.execute(tableName(fields))
    return sql.openDatabase(path.join(dbPath, 'score.db'),
        onCreate: (db, version) {
      db.execute("PRAGMA foreign_keys = ON");
      return db.execute(
          '''CREATE TABLE app_settings(
            id INTEGER PRIMARY KEY, 
            setting TEXT, 
            active INTEGER
            )''');
      // db.execute(
      //     '''CREATE TABLE players(
      //       id INTEGER PRIMARY KEY, 
      //       firstname TEXT,
      //       lastname TEXT, 
      //       wins INTEGER
      //       )''');
      // db.execute(
      //     '''CREATE TABLE teams(
      //       id INTEGER PRIMARY KEY, 
      //       name TEXT,
      //       wins INTEGER
      //       )''');
      // db.execute(
      //     '''CREATE TABLE games(
      //       id INTEGER PRIMARY KEY, 
      //       name TEXT,
      //       description TEXT, 
      //       endscore INTEGER, 
      //       lowscore INTEGER,
      //       )''');
      // db.execute(
      //     '''CREATE TABLE indv_matches(
      //       game_id INTEGER,
      //       player1_id INTEGER,
      //       player2_id INTEGER,   
      //       FOREIGN KEY(game_id) REFERENCES games(id),
      //       FOREIGN KEY(player1_id) REFERENCES players(id),
      //       FOREIGN KEY(player2_id) REFERENCES players(id),
      //       )''');
      // db.execute(
      //     '''CREATE TABLE team_matches(
      //       game_id INTEGER,
      //       team1_id INTEGER,
      //       team2_id INTEGER,   
      //       FOREIGN KEY(game_id) REFERENCES games(id),
      //       FOREIGN KEY(team1_id) REFERENCES teams(id),
      //       FOREIGN KEY(team2_id) REFERENCES teams(id),
      //       )''');
    }, version: 1);
  }

  static Future<void> insert(
    String table,
    Map<String, Object?> data,
  ) async {
    // gets access to the database
    final db = await DBHelper.database();
    // Insert into the database
    db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, Object?>>> getData(String table) async {
    // gets access to the database
    final db = await DBHelper.database();
    // get the data from the db it will return a List of Maps
    return db.query(table);
  }
}
