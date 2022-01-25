import 'dart:async';
import 'package:beehappy/model/notes/db_notes.dart';
import 'package:beehappy/model/notes/notes_model.dart';
import 'package:beehappy/screens/notes_views/notes_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sqflite/sqflite.dart';
import '../../model/theme.dart' as theme;

class NotesMain extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NotesMainState();
  }
}

class NotesMainState extends State<NotesMain> {
  DBNotes dbNotes = DBNotes();
  List<Notes> notesList;
  int count = 0;
  int axisCount = 2;

  @override
  Widget build(BuildContext context) {
    if (notesList == null) {
      notesList = List<Notes>();
      updateListView();
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Notatki', style: TextStyle(color: theme.fontColor)),
        backgroundColor: theme.mainColor,
      ),
      body: notesList.length == 0
          ? Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('assets/${theme.bgImage}'),
                fit: BoxFit
                    .cover, //zasłoni cały background, -> umiejscowienie image w bgc
              )),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text('Naciśnij Przycisk by dodać!'),
                ),
              ),
            )
          : Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('assets/${theme.bgImage}'),
                fit: BoxFit
                    .cover, //zasłoni cały background, -> umiejscowienie image w bgc
              )),
              child: getList(),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateToDetail(Notes('', ''), 'Dodaj przypomnienie');
        },
        tooltip: 'Add Note',
        shape: CircleBorder(side: BorderSide(color: Colors.black, width: 2.0)),
        child: Icon(Icons.add, color: Colors.black),
        backgroundColor: Colors.yellow[50],
      ),
    );
  }

  Widget getList() {
    return StaggeredGridView.countBuilder(
      physics: BouncingScrollPhysics(),
      crossAxisCount: 4,
      itemCount: count,
      itemBuilder: (BuildContext context, int index) => GestureDetector(
        onTap: () {
          navigateToDetail(this.notesList[index], 'Edytuj przypomnienie');
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                color: theme.subColor2,
                border: Border.all(width: 2, color: Colors.black),
                borderRadius: BorderRadius.circular(8.0)),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          this.notesList[index].title,
                          style: TextStyle(
                            color: theme.fontColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          this.notesList[index].desc == null
                              ? ''
                              : this.notesList[index].desc,
                          style: TextStyle(
                            color: theme.fontColor,
                            fontSize: 18.0,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        this.notesList[index].date,
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ])
              ],
            ),
          ),
        ),
      ),
      staggeredTileBuilder: (int index) => StaggeredTile.fit(axisCount),
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
    );
  }

  void navigateToDetail(Notes note, String title) async {
    bool result = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => NotesDetail(note, title)));

    if (result == true) {
      updateListView();
    }
  }

  void updateListView() {
    final Future<Database> dbFuture = dbNotes.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Notes>> noteListFuture = dbNotes.getNoteList();
      noteListFuture.then((notesList) {
        setState(() {
          this.notesList = notesList;
          this.count = notesList.length;
        });
      });
    });
  }
}
