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
      db.execute('''CREATE TABLE app_settings(
            id INTEGER PRIMARY KEY , 
            setting TEXT, 
            active INTEGER
            )''');
      db.execute('''CREATE TABLE players(
            id INTEGER PRIMARY KEY AUTOINCREMENT, 
            name TEXT,
            wins INTEGER,
            is_selected INTEGER
            )''');
      db.execute('''CREATE TABLE teams(
            id INTEGER PRIMARY KEY, 
            name TEXT,
            wins INTEGER
            )''');
      db.execute('''CREATE TABLE games(
            id INTEGER PRIMARY KEY AUTOINCREMENT, 
            name TEXT UNIQUE,
            description TEXT, 
            end_score INTEGER, 
            low_score INTEGER
            )''');
      db.execute('''CREATE TABLE indv_matches(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            match_name TEXT,
            game_name TEXT,
            game_id INTEGER,
            player1_name TEXT,
            player2_name TEXT,
            player1_id INTEGER,
            player2_id INTEGER,
            player1_score INTEGER,
            player2_score INTEGER,
            player1_color TEXT,
            player2_color TEXT,
            winner TEXT,
            win_score INTEGER,
            low_score INTEGER,
            is_complete INTEGER, 
            FOREIGN KEY(game_name) REFERENCES games(name) ON DELETE NO ACTION ON UPDATE NO ACTION, 
            FOREIGN KEY(game_id) REFERENCES games(id) ON DELETE NO ACTION ON UPDATE NO ACTION,
            FOREIGN KEY(player1_name) REFERENCES players(name) ON DELETE NO ACTION ON UPDATE NO ACTION,
            FOREIGN KEY(player2_name) REFERENCES players(name) ON DELETE NO ACTION ON UPDATE NO ACTION,
            FOREIGN KEY(player1_id) REFERENCES players(id) ON DELETE NO ACTION ON UPDATE NO ACTION,
            FOREIGN KEY(player2_id) REFERENCES players(id) ON DELETE NO ACTION ON UPDATE NO ACTION,
            FOREIGN KEY(win_score) REFERENCES games(end_score) ON DELETE NO ACTION ON UPDATE NO ACTION,
            FOREIGN KEY(low_score) REFERENCES games(low_score) ON DELETE NO ACTION ON UPDATE NO ACTION
            )''');
      db.execute('''CREATE TABLE team_matches(
            game_id INTEGER,
            team1_id INTEGER,
            team2_id INTEGER,   
            FOREIGN KEY(game_id) REFERENCES games(id),
            FOREIGN KEY(team1_id) REFERENCES teams(id),
            FOREIGN KEY(team2_id) REFERENCES teams(id)
            )''');
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

  static Future<List<Map<String, Object?>>> getDataById(String table, int id) async {
    // gets access to the database
    final db = await DBHelper.database();
    // get the data from the db it will return a List of Maps
    return db.query(table, where: "id = ", whereArgs: [id]);
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
