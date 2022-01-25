import 'package:beehappy/model/inspection/db_inspection.dart';
import 'package:beehappy/model/inspection/inspection_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/theme.dart' as theme;

class AddInspection extends StatefulWidget {
  @override
  _AddInspectionState createState() => _AddInspectionState();
}

class _AddInspectionState extends State<AddInspection> {
  final DBInspection getDB = DBInspection();

  final FocusNode nameNode = FocusNode();
  final FocusNode dateNode = FocusNode();
  final FocusNode descNode = FocusNode();

  // capture input from TextField
  var nameController = TextEditingController();
  var dateController = TextEditingController();
  var descController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final getDB = Provider.of<DBInspection>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.mainColor,
        centerTitle: true,
        title: Text('Dodaj nowy przegląd',
            style: TextStyle(color: theme.fontColor)),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/${theme.bgImage}'),
            fit: BoxFit
                .cover, //zasłoni cały background, -> umiejscowienie image w bgc
          )),
          padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  style: TextStyle(
                    color: theme.fontColor,
                    fontSize: 16.0,
                  ),
                  autofocus: true,
                  textInputAction: TextInputAction.next,
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Nazwa przeglądu',
                    labelStyle: TextStyle(color: theme.fontColor),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide(
                        color: theme.fontColor,
                        width: 2.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: theme.fontColor,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onEditingComplete: () {
                    FocusScope.of(context).requestFocus(dateNode);
                  },
                  validator: (val) =>
                      val.isEmpty ? 'Musisz dodać nazwę przeglądu!' : null,
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  style: TextStyle(
                    color: theme.fontColor,
                    fontSize: 16.0,
                  ),
                  focusNode: dateNode,
                  controller: dateController,
                  decoration: InputDecoration(
                    labelText: 'Data przeglądu',
                    labelStyle: TextStyle(color: theme.fontColor),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide(
                        color: theme.fontColor,
                        width: 2.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: theme.fontColor,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onEditingComplete: () {
                    FocusScope.of(context).requestFocus(descNode);
                  },
                  validator: (val) => val.isEmpty
                      ? 'Musisz dodać datę wykonania przeglądu!'
                      : null,
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  style: TextStyle(
                    color: theme.fontColor,
                    fontSize: 16.0,
                  ),
                  focusNode: descNode,
                  textInputAction: TextInputAction.next,
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,
                  controller: descController,
                  decoration: InputDecoration(
                    labelText: 'Opis',
                    labelStyle: TextStyle(color: theme.fontColor),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide(
                        color: theme.fontColor,
                        width: 2.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: theme.fontColor,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                RaisedButton(
                  color: theme.redColor,
                  child: Text(
                    'Dodaj',
                    style: TextStyle(
                      color: theme.fontColor,
                      fontSize: 20.0,
                    ),
                  ),
                  shape: StadiumBorder(),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      InspectionModel newInspection = InspectionModel(
                          nameController.text,
                          dateController.text,
                          descController.text ?? "");

                      getDB.addInspection(newInspection).then((i) {
                        nameController.clear();
                        dateController.clear();
                        descController.clear();
                        newInspection = null;
                      });
                      Navigator.pop(context);
                    }
                  },
                ),
                SizedBox(height: 400.0),
              ],
            ),
          ),
        ),
      )),
      resizeToAvoidBottomInset: false,
    );
  }
}
