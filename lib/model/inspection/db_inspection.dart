import 'package:beehappy/model/inspection/inspection_model.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

class DBInspection with ChangeNotifier {
  // Transform DBManager to singleton class.
  DBInspection._internal();
  static final DBInspection _dbManager = DBInspection._internal();
  factory DBInspection() => _dbManager;

  // constant class properties
  final tblInspection = 'inspection';
  final colId = 'id';
  final colName = 'name';
  final colDate = 'date';
  final colDesc = 'description';

  Database db;

  Future<Database> initializeDB() async {
    if (db == null) {
      db = await openDatabase(join(await getDatabasesPath(), "inspection.db"),
          version: 1, onCreate: (db, int version) {
        return db.execute(
            "CREATE TABLE $tblInspection($colId INTEGER PRIMARY KEY, $colName TEXT, $colDate TEXT, $colDesc TEXT)");
      });
    }
    return db;
  }

  // insert data into DB
  Future<int> addInspection(InspectionModel inspection) async {
    await initializeDB();
    var newInspection = await db.insert(tblInspection, inspection.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    notifyListeners();
    return newInspection;
  }

  // retrieve all
  Future<List<InspectionModel>> getInspection() async {
    await initializeDB();
    final List<Map<String, dynamic>> allInspections =
        await db.rawQuery("SELECT * FROM $tblInspection ORDER BY $colName ASC");
    return List.generate(allInspections.length, (i) {
      return InspectionModel.withId(
        allInspections[i][colId],
        allInspections[i][colName],
        allInspections[i][colDate],
        allInspections[i][colDesc],
      );
    });
  }

  // update
  Future<int> updateInspection(InspectionModel inspection) async {
    await initializeDB();
    notifyListeners();
    return await db.update(tblInspection, inspection.toMap(),
        where: "$colId = ?", whereArgs: [inspection.id]);
  }

  // delete
  Future<int> deleteInspection(int id) async {
    await initializeDB();
    notifyListeners();
    return await db.delete(tblInspection, where: "$colId = ?", whereArgs: [id]);
  }
}
