import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBPhotosModel {
  static Future<Database> database() async {
    final String dbPath = await getDatabasesPath();
    final String createTabelQuery = """
    CREATE TABLE PHOTOS(
      id TEXT PRIMARY KEY,
      image TEXT
    )
    """;
    return openDatabase(
      join(dbPath, "photos.db"),
      onCreate: (db, version) {
        return db.execute(createTabelQuery);
      },
      version: 1,
    );
  }

  static Future insert(String table, Map<String, Object> data) async {
    final Database db = await DBPhotosModel.database();
    db.insert(table, data, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> delete(String table, String id) async {
    final Database db = await DBPhotosModel.database();
    db.delete(table, where: "id = ?", whereArgs: [id]);
  }

  static Future<List<Map<String, dynamic>>> read(String table) async {
    final Database db = await DBPhotosModel.database();
    return db.query(table);
  }
}
