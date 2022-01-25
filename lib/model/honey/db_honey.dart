import 'package:beehappy/model/honey/honey_model.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

class DBHoney with ChangeNotifier {
  // Transform DBManager to singleton class.
  DBHoney._internal();
  static final DBHoney _dbManager = DBHoney._internal();
  factory DBHoney() => _dbManager;

  // constant class properties
  final tblHoney = 'honey';
  final colId = 'id';
  final colType = 'type';
  final colDate = 'date';
  final colAmount = 'amount';
  final colPrice = 'price';
  final colPercent = 'percent';

  Database db;

  Future<Database> initializeDB() async {
    if (db == null) {
      db = await openDatabase(join(await getDatabasesPath(), "honey.db"),
          version: 1, onCreate: (db, int version) {
        return db.execute(
            "CREATE TABLE $tblHoney($colId INTEGER PRIMARY KEY, $colType TEXT, $colDate TEXT, $colAmount INTEGER, $colPrice TEXT, $colPercent  INTEGER)");
      });
    }
    return db;
  }

  // insert data into DB
  Future<int> addHoney(HoneyModel honey) async {
    await initializeDB();
    var newHoney = await db.insert(tblHoney, honey.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    notifyListeners();
    return newHoney;
  }

  // retrieve all
  Future<List<HoneyModel>> getHoney() async {
    await initializeDB();
    final List<Map<String, dynamic>> allHoney =
        await db.rawQuery("SELECT * FROM $tblHoney ORDER BY $colType ASC");
    return List.generate(allHoney.length, (i) {
      return HoneyModel.withId(
        allHoney[i][colId],
        allHoney[i][colType],
        allHoney[i][colDate],
        allHoney[i][colAmount],
        allHoney[i][colPrice],
        allHoney[i][colPercent],
      );
    });
  }

  // update
  Future<int> updateHoney(HoneyModel honey) async {
    await initializeDB();
    notifyListeners();
    return await db.update(tblHoney, honey.toMap(),
        where: "$colId = ?", whereArgs: [honey.id]);
  }

  // delete
  Future<int> deleteHoney(int id) async {
    await initializeDB();
    notifyListeners();
    return await db.delete(tblHoney, where: "$colId = ?", whereArgs: [id]);
  }
}
