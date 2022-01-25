import 'dart:io';

import 'package:beehappy/model/notes/notes_model.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';

import 'notes_model.dart';

class DBNotes {
  static DBNotes _dbNotes; // Singleton DBNotes
  static Database _database; // Singleton Database

  String notesTable = 'note_table';
  String colId = 'id';
  String colTitle = 'title';
  String colDesc = 'desc';
  String colDate = 'date';

  DBNotes._createInstance(); // Named constructor to create instance of DBNotes

  factory DBNotes() {
    if (_dbNotes == null) {
      _dbNotes = DBNotes
          ._createInstance(); // This is executed only once, singleton object
    }
    return _dbNotes;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    // Get the directory path for both Android and iOS to store database.
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'notes.db';

    // Open/create the database at a given path
    var notesDB = await openDatabase(path, version: 1, onCreate: _createDb);
    return notesDB;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $notesTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, '
        '$colDesc TEXT ,$colDate TEXT)');
  }

  Future<List<Map<String, dynamic>>> getNoteMapList() async {
    Database db = await this.database;

    var result = await db.query(notesTable, orderBy: '$colDate ASC');
    return result;
  }

  // Insert Operation: Insert a object to database
  Future<int> insert(Notes notes) async {
    Database db = await this.database;
    var result = await db.insert(notesTable, notes.toMap());
    return result;
  }

  // Update Operation: Update a object and save it to database
  Future<int> update(Notes notes) async {
    var db = await this.database;
    var result = await db.update(notesTable, notes.toMap(),
        where: '$colId = ?', whereArgs: [notes.id]);
    return result;
  }

  // Delete Operation: Delete a object from database
  Future<int> delete(int id) async {
    var db = await this.database;
    int result =
        await db.rawDelete('DELETE FROM $notesTable WHERE $colId = $id');
    return result;
  }

  // Get number of objects in database
  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $notesTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<List<Notes>> getNoteList() async {
    var notesMapList = await getNoteMapList();
    int count = notesMapList.length;

    List<Notes> notesList = List<Notes>();

    for (int i = 0; i < count; i++) {
      notesList.add(Notes.fromMapObject(notesMapList[i]));
    }

    return notesList;
  }
}
