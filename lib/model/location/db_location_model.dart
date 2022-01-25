import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBLocationModel {
  static Future<Database> database() async {
    final String dbPath = await getDatabasesPath();
    final String createTabelQuery = """
    CREATE TABLE PLACES(
      id TEXT PRIMARY KEY,
      title TEXT,
      image TEXT,
      loc_latitude REAL,
      loc_longitude REAL,
      address TEXT
    )
    """;
    return openDatabase(
      join(dbPath, "places.db"),
      onCreate: (db, version) {
        return db.execute(createTabelQuery);
      },
      version: 1,
    );
  }

  static Future insert(String table, Map<String, Object> data) async {
    final Database db = await DBLocationModel.database();
    db.insert(table, data, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> delete(String table, String id) async {
    final Database db = await DBLocationModel.database();
    db.delete(table, where: "id = ?", whereArgs: [id]);
  }

  static Future<List<Map<String, dynamic>>> read(String table) async {
    final Database db = await DBLocationModel.database();
    return db.query(table);
  }
}
