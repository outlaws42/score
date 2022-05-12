import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'dart:async';

class DBHelper {
  static Future<sql.Database> database() async {
    // Get the Database path
    final dbPath = await sql.getDatabasesPath();
    // Path of the db and the db name, onCreate is done only when creating the
    // db.execute(tableName(fields))
    return sql.openDatabase(path.join(dbPath, 'score.db'),
        onCreate: (db, version) {
      db.execute("PRAGMA foreign_keys = ON");
      db.execute('''CREATE TABLE setting(
            id INTEGER PRIMARY KEY , 
            setting TEXT, 
            active INTEGER
            )''');
      // db.execute('''CREATE TABLE player(
      //       id TEXT PRIMARY KEY, 
      //       name TEXT,
      //       wins INTEGER,
      //       is_selected INTEGER,
      //       date_time INTEGER
      //       )''');
      // db.execute('''CREATE TABLE team(
      //       id TEXT PRIMARY KEY, 
      //       name TEXT,
      //       player1_name TEXT,
      //       player2_name TEXT,
      //       player1_id INTEGER,
      //       player2_id INTEGER,
      //       wins INTEGER,
      //       is_selected INTEGER,
      //       date_time INTEGER,
      //       FOREIGN KEY(player1_name) REFERENCES players(name) ON DELETE NO ACTION ON UPDATE NO ACTION,
      //       FOREIGN KEY(player2_name) REFERENCES players(name) ON DELETE NO ACTION ON UPDATE NO ACTION,
      //       FOREIGN KEY(player1_id) REFERENCES players(id) ON DELETE NO ACTION ON UPDATE NO ACTION,
      //       FOREIGN KEY(player2_id) REFERENCES players(id) ON DELETE NO ACTION ON UPDATE NO ACTION
      //       )''');
      // db.execute('''CREATE TABLE game(
      //       id TEXT PRIMARY KEY, 
      //       name TEXT UNIQUE,
      //       description TEXT, 
      //       end_score INTEGER, 
      //       low_score INTEGER,
      //       free_play INTEGER,
      //       is_selected INTEGER,
      //       date_time INTEGER
      //       )''');
      // db.execute('''CREATE TABLE player_match(
      //       id TEXT PRIMARY KEY,
      //       game_name TEXT,
      //       game_id TEXT,
      //       winner TEXT,
      //       winner_id TEXT,
      //       win_score INTEGER,
      //       low_score INTEGER,
      //       is_complete INTEGER,
      //       is_selected INTEGER,
      //       date_time INTEGER, 
      //       FOREIGN KEY(_id) REFERENCES games(id) ON DELETE NO ACTION ON UPDATE NO ACTION,
      //       )''');
      // db.execute('''CREATE TABLE team_match(
      //       id TEXT PRIMARY KEY,
      //       match_name TEXT,
      //       game_name TEXT,
      //       game_id INTEGER,
      //       winner TEXT,
      //       winner_id INTEGER,
      //       win_score INTEGER,
      //       low_score INTEGER,
      //       is_complete INTEGER,
      //       free_play INTEGER,
      //       is_selected INTEGER,
      //       date_time INTEGER, 
      //       team1_name TEXT,
      //       team2_name TEXT,
      //       team3_name TEXT,
      //       team4_name TEXT,
      //       team5_name TEXT,
      //       team6_name TEXT,
      //       team7_name TEXT,
      //       team8_name TEXT,
      //       team9_name TEXT,
      //       team10_name TEXT,
      //       team1_id INTEGER,
      //       team2_id INTEGER,
      //       team3_id INTEGER,
      //       team4_id INTEGER,
      //       team5_id INTEGER,
      //       team6_id INTEGER,
      //       team7_id INTEGER,
      //       team8_id INTEGER,
      //       team9_id INTEGER,
      //       team10_id INTEGER,
      //       team1_score INTEGER,
      //       team2_score INTEGER,
      //       team3_score INTEGER,
      //       team4_score INTEGER,
      //       team5_score INTEGER,
      //       team6_score INTEGER,
      //       team7_score INTEGER,
      //       team8_score INTEGER,
      //       team9_score INTEGER,
      //       team10_score INTEGER,
      //       team1_color INTGER,
      //       team2_color INTEGER,
      //       team3_color INTEGER,
      //       team4_color INTEGER,
      //       team5_color INTEGER,
      //       team6_color INTEGER,
      //       team7_color INTEGER,
      //       team8_color INTEGER,
      //       team9_color INTEGER,
      //       team10_color INTEGER,
      //       FOREIGN KEY(game_name) REFERENCES games(name) ON DELETE NO ACTION ON UPDATE NO ACTION, 
      //       FOREIGN KEY(game_id) REFERENCES games(id) ON DELETE NO ACTION ON UPDATE NO ACTION,
      //       FOREIGN KEY(team1_name) REFERENCES teams(name) ON DELETE NO ACTION ON UPDATE NO ACTION,
      //       FOREIGN KEY(team2_name) REFERENCES teams(name) ON DELETE NO ACTION ON UPDATE NO ACTION,
      //       FOREIGN KEY(team1_id) REFERENCES teams(id) ON DELETE NO ACTION ON UPDATE NO ACTION,
      //       FOREIGN KEY(team2_id) REFERENCES teams(id) ON DELETE NO ACTION ON UPDATE NO ACTION,
      //       FOREIGN KEY(win_score) REFERENCES games(end_score) ON DELETE NO ACTION ON UPDATE NO ACTION,
      //       FOREIGN KEY(low_score) REFERENCES games(low_score) ON DELETE NO ACTION ON UPDATE NO ACTION,
      //       FOREIGN KEY(free_play) REFERENCES games(free_play) ON DELETE NO ACTION ON UPDATE NO ACTION
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

  static Future<List<Map<String, Object?>>> getDataByWinnerId(String table, int id) async {
    // gets access to the database
    final db = await DBHelper.database();
    // get the data from the db it will return a List of Maps
    return db.query(table, where: "winner_id = ?", whereArgs: [id]);
  }

  static Future<void> remove(String table, int id) async {
    final db = await DBHelper.database();
    await db.delete(
      table,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<void> update(
    String table,
    int id,
    Map<String, Object?> data,
  ) async {
    final db = await DBHelper.database();
    await db.update(
      table,
      data,
      where: 'id = ?',
      whereArgs: [id],
      
    );
  }  
}
