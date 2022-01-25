import 'package:beehappy/model/families/family_model.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

class DBFamily with ChangeNotifier {
  // Transform DBManager to singleton class.
  DBFamily._internal();
  static final DBFamily _dbManager = DBFamily._internal();
  factory DBFamily() => _dbManager;

  // constant class properties
  final tblFamilies = 'families';
  final colId = 'id';
  final colName = 'name';
  final colHivesNumber = 'hivesNumber';
  final colHoney = 'honey';
  final colLocation = 'location';
  final colLitersNumber = 'litersNumber';

  Database db;

  Future<Database> initializeDB() async {
    if (db == null) {
      db = await openDatabase(join(await getDatabasesPath(), "families.db"),
          version: 1, onCreate: (db, int version) {
        return db.execute(
            "CREATE TABLE $tblFamilies($colId INTEGER PRIMARY KEY, $colName TEXT, $colHivesNumber INTEGER, $colHoney TEXT, $colLocation TEXT, $colLitersNumber INTEGER)");
      });
    }
    return db;
  }

  // insert data into DB
  Future<int> addFamilies(FamilyModel families) async {
    await initializeDB();
    var newFamilies = await db.insert(tblFamilies, families.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    notifyListeners();
    return newFamilies;
  }

  // retrieve all
  Future<List<FamilyModel>> getFamilies() async {
    await initializeDB();
    final List<Map<String, dynamic>> allFamilies =
        await db.rawQuery("SELECT * FROM $tblFamilies ORDER BY $colName ASC");
    return List.generate(allFamilies.length, (i) {
      return FamilyModel.withId(
        allFamilies[i][colId],
        allFamilies[i][colName],
        allFamilies[i][colHivesNumber],
        allFamilies[i][colHoney],
        allFamilies[i][colLocation],
        allFamilies[i][colLitersNumber],
      );
    });
  }

  // update
  Future<int> updateFamilies(FamilyModel families) async {
    await initializeDB();
    notifyListeners();
    return await db.update(tblFamilies, families.toMap(),
        where: "$colId = ?", whereArgs: [families.id]);
  }

  // delete
  Future<int> deleteFamilies(int id) async {
    await initializeDB();
    notifyListeners();
    return await db.delete(tblFamilies, where: "$colId = ?", whereArgs: [id]);
  }
}
