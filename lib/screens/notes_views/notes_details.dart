import 'package:beehappy/model/notes/db_notes.dart';
import 'package:beehappy/model/notes/notes_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../model/theme.dart' as theme;

class NotesDetail extends StatefulWidget {
  final String appBarTitle;
  final Notes notes;

  NotesDetail(this.notes, this.appBarTitle);

  @override
  State<StatefulWidget> createState() {
    return NoteDetailState(this.notes, this.appBarTitle);
  }
}

class NoteDetailState extends State<NotesDetail> {
  DBNotes dbNotes = DBNotes();

  String appBarTitle;
  Notes notes;
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  // int color;
  bool isEdited = false;

  NoteDetailState(this.notes, this.appBarTitle);

  @override
  Widget build(BuildContext context) {
    titleController.text = notes.title;
    descController.text = notes.desc;
    return WillPopScope(
        onWillPop: () {
          isEdited ? showDiscardDialog(context) : moveToLastScreen();
        },
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: Text(
              appBarTitle,
            ),
            backgroundColor: theme.mainColor,
            leading: IconButton(
                icon: Icon(Icons.arrow_back_ios, color: theme.fontColor),
                onPressed: () {
                  isEdited ? showDiscardDialog(context) : moveToLastScreen();
                }),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.save,
                  color: theme.fontColor,
                ),
                onPressed: () {
                  titleController.text.length == 0
                      ? showEmptyTitleDialog(context)
                      : _save();
                },
              ),
              IconButton(
                icon: Icon(Icons.delete, color: theme.fontColor),
                onPressed: () {
                  showDeleteDialog(context);
                },
              )
            ],
          ),
          body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/${theme.bgImage}'),
              fit: BoxFit
                  .cover, //zasłoni cały background, -> umiejscowienie image w bgc
            )),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: TextField(
                    style: TextStyle(
                      color: theme.fontColor,
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                    ),
                    controller: titleController,
                    maxLength: 255,
                    onChanged: (value) {
                      updateTitle();
                    },
                    decoration: InputDecoration.collapsed(
                      hintText: 'Tytuł',
                      hintStyle: TextStyle(
                        color: theme.fontColor,
                        fontSize: 22.0,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: TextField(
                      style: TextStyle(
                        color: theme.fontColor,
                        fontSize: 18.0,
                      ),
                      keyboardType: TextInputType.multiline,
                      maxLines: 10,
                      maxLength: 255,
                      controller: descController,
                      onChanged: (value) {
                        updateDescription();
                      },
                      decoration: InputDecoration.collapsed(
                        hintText: 'Opis',
                        hintStyle: TextStyle(
                          color: theme.fontColor,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  void showDiscardDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          title: Text(
            "Odrzuć zmiany!",
            style: TextStyle(
              color: theme.fontColor,
              fontWeight: FontWeight.bold,
              fontSize: 22.0,
            ),
          ),
          content: Text(
            "Czy chcesz odrzucić zmiany?",
            style: TextStyle(
              color: theme.fontColor,
              fontSize: 18.0,
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                "Nie",
                style: TextStyle(
                  color: theme.fontColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 22.0,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text(
                "Tak",
                style: TextStyle(
                  color: theme.fontColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 22.0,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                moveToLastScreen();
              },
            ),
          ],
        );
      },
    );
  }

  void showEmptyTitleDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          title: Text(
            "Brak Tytułu!",
            style: TextStyle(
              color: theme.fontColor,
              fontSize: 18.0,
            ),
          ),
          content: Text(
            'Musisz dodać tytuł Przypomnienia!',
            style: TextStyle(
              color: theme.fontColor,
              fontSize: 18.0,
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                "Ok",
                style: TextStyle(
                  color: theme.fontColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 22.0,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void showDeleteDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Usuń Notatkę!',
              textAlign: TextAlign.center,
            ),
            content: Text(
              'Czy chcesz usunąć notatkę?',
              textAlign: TextAlign.center,
            ),
            backgroundColor: theme.subColor2,
            elevation: 8.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            actions: <Widget>[
              OutlineButton(
                borderSide: BorderSide(color: Colors.black),
                shape: StadiumBorder(),
                child: Text(
                  'Tak',
                  style: TextStyle(
                      fontSize: 18.0,
                      letterSpacing: 1.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  _delete();
                },
              ),
            ],
          );
        });
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  void updateTitle() {
    isEdited = true;
    notes.title = titleController.text;
  }

  void updateDescription() {
    isEdited = true;
    notes.desc = descController.text;
  }

  // Save data to database
  void _save() async {
    moveToLastScreen();

    notes.date = DateFormat.yMMMd().format(DateTime.now());

    if (notes.id != null) {
      await dbNotes.update(notes);
    } else {
      await dbNotes.insert(notes);
    }
  }

  void _delete() async {
    await dbNotes.delete(notes.id);
    moveToLastScreen();
  }
}
