import 'package:beehappy/model/inspection/db_inspection.dart';
import 'package:beehappy/model/inspection/inspection_model.dart';
import 'package:flutter/material.dart';
import '../../model/theme.dart' as theme;

class EditInspection extends StatefulWidget {
  final InspectionModel inspection;
  EditInspection(this.inspection);

  @override
  _EditInspectionState createState() => _EditInspectionState();
}

class _EditInspectionState extends State<EditInspection> {
  final DBInspection getDB = DBInspection();

  // capture input from TextField
  var nameController = TextEditingController();
  var dateController = TextEditingController();
  var descController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    InspectionModel inspection = widget.inspection;
    // filled values to Form input field
    nameController.text = widget.inspection.name;
    dateController.text = widget.inspection.date;
    descController.text = widget.inspection.description;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.mainColor,
        centerTitle: true,
        title: Text('Przegląd', style: TextStyle(color: theme.fontColor)),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/${theme.bgImage}'),
          fit: BoxFit
              .cover, //zasłoni cały background, -> umiejscowienie image w bgc
        )),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      style: TextStyle(
                        color: theme.fontColor,
                        fontSize: 16.0,
                      ),
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
                      height: 30.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RaisedButton(
                          color: theme.redColor,
                          child: Text(
                            'Zapisz',
                            style: TextStyle(
                              color: theme.fontColor,
                              fontSize: 20.0,
                            ),
                          ),
                          shape: StadiumBorder(),
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              inspection.name = nameController.text;
                              inspection.date = dateController.text;
                              inspection.description =
                                  descController.text ?? '';

                              getDB.updateInspection(inspection);
                              Navigator.pop(context);
                            }
                          },
                        ),
                        SizedBox(
                          width: 30.0,
                        ),
                        RaisedButton(
                          color: theme.redColor,
                          child: Text(
                            'Usuń',
                            style: TextStyle(
                              color: theme.fontColor,
                              fontSize: 20.0,
                            ),
                          ),
                          shape: StadiumBorder(),
                          onPressed: () {
                            showDialog(
                                context: context,
                                barrierDismissible: true,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text(
                                      'Usuń Przegląd!',
                                      textAlign: TextAlign.center,
                                    ),
                                    content: Text(
                                      'Czy chcesz usunąć przegląd ${inspection.name}?',
                                      textAlign: TextAlign.center,
                                    ),
                                    backgroundColor: Colors.yellow[50],
                                    elevation: 8.0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    actions: <Widget>[
                                      OutlineButton(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                        shape: StadiumBorder(),
                                        child: Text(
                                          'Tak',
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              letterSpacing: 1.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                        onPressed: () async {
                                          await getDB
                                              .deleteInspection(inspection.id);
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  );
                                });
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 400.0),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
