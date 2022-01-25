import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

import 'bee_info_model.dart';

class DBBeeInfo with ChangeNotifier {
  // Transform DBManager to singleton class.
  DBBeeInfo._internal();
  static final DBBeeInfo _dbManager = DBBeeInfo._internal();
  factory DBBeeInfo() => _dbManager;

  // constant class properties
  final tblBeeInfo = 'beeinfo';
  final colId = 'id';
  final colName = 'name';
  final colHivesNumber = 'hivesNumber';
  final colYear = 'year';
  final colBeekeeper = 'beekeeper';
  final colBeekeeperNumber = 'beekeeperNumber';
  final colCharacter = 'character';
  final colDistrict = 'district';

  Database db;

  Future<Database> initializeDB() async {
    if (db == null) {
      db = await openDatabase(join(await getDatabasesPath(), "beeinfo.db"),
          version: 1, onCreate: (db, int version) {
        return db.execute(
            "CREATE TABLE $tblBeeInfo($colId INTEGER PRIMARY KEY, $colName TEXT, $colHivesNumber INTEGER, $colYear INTEGER, $colBeekeeper TEXT, $colBeekeeperNumber INTEGER, $colCharacter TEXT, $colDistrict TEXT)");
      });
    }
    return db;
  }

  // insert data into DB
  Future<int> addBeeInfo(BeeInfoModel beeinfos) async {
    await initializeDB();
    var newBeeInfo = await db.insert(tblBeeInfo, beeinfos.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    notifyListeners();
    return newBeeInfo;
  }

  // retrieve all
  Future<List<BeeInfoModel>> getBeeInfo() async {
    await initializeDB();
    final List<Map<String, dynamic>> allBeeInfo =
        await db.rawQuery("SELECT * FROM $tblBeeInfo ORDER BY $colName ASC");
    return List.generate(allBeeInfo.length, (i) {
      return BeeInfoModel.withId(
       allBeeInfo[i][colId],
        allBeeInfo[i][colName],
        allBeeInfo[i][colHivesNumber],
        allBeeInfo[i][colYear],
        allBeeInfo[i][colBeekeeper],
        allBeeInfo[i][colBeekeeperNumber],
        allBeeInfo[i][colCharacter],
        allBeeInfo[i][colDistrict],
      );
    });
  }

  // update
  Future<int> updateBeeInfo(BeeInfoModel beeinfos) async {
    await initializeDB();
    notifyListeners();
    return await db.update(tblBeeInfo, beeinfos.toMap(),
        where: "$colId = ?", whereArgs: [beeinfos.id]);
  }

  // delete
  Future<int> deleteBeeInfo(int id) async {
    await initializeDB();
    notifyListeners();
    return await db.delete(tblBeeInfo, where: "$colId = ?", whereArgs: [id]);
  }
}
