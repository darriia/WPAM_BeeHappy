import 'package:beehappy/model/families/db_family.dart';
import 'package:beehappy/model/families/family_model.dart';
import 'package:flutter/material.dart';
import 'package:form_validators/form_validators.dart';
import '../../model/theme.dart' as theme;

class EditFamilies extends StatefulWidget {
  final FamilyModel families;
  EditFamilies(this.families);

  @override
  _EditFamiliesState createState() => _EditFamiliesState();
}

class _EditFamiliesState extends State<EditFamilies> {
  final DBFamily getDB = DBFamily();

  // capture input from TextField
  var nameController = TextEditingController();
  var hivesNumberController = TextEditingController();
  var honeyController = TextEditingController();
  var locationController = TextEditingController();
  var litersNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    FamilyModel families = widget.families;
    // filled values to Form input field
    nameController.text = widget.families.name;
    hivesNumberController.text = widget.families.hivesNumber.toString();
    honeyController.text = widget.families.honey;
    locationController.text = widget.families.location;
    litersNumberController.text = widget.families.litersNumber.toString();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.mainColor,
        centerTitle: true,
        title: Text('Rodzina ${families.name}',
            style: TextStyle(color: theme.fontColor)),
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
                        labelText: 'Nazwa',
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
                          val.isEmpty ? 'Musisz dodać nazwę rodziny!' : null,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      style: TextStyle(
                        color: theme.fontColor,
                        fontSize: 16.0,
                      ),
                      controller: hivesNumberController,
                      decoration: InputDecoration(
                        labelText: 'Liczba uli',
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
                          val.isEmpty ? 'Musisz dodać liczbe uli!' : null,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      style: TextStyle(
                        color: theme.fontColor,
                        fontSize: 16.0,
                      ),
                      controller: honeyController,
                      decoration: InputDecoration(
                        labelText: 'Rodzaj miodu',
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
                    TextFormField(
                      style: TextStyle(
                        color: theme.fontColor,
                        fontSize: 16.0,
                      ),
                      controller: locationController,
                      decoration: InputDecoration(
                        labelText: 'Lokalizacja rodziny',
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
                    TextFormField(
                      style: TextStyle(
                        color: theme.fontColor,
                        fontSize: 16.0,
                      ),
                      controller: litersNumberController,
                      decoration: InputDecoration(
                        labelText: 'Liczba ltrów wyprodukowanego miodu',
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
                              families.name = nameController.text;
                              families.hivesNumber =
                                  int.parse(hivesNumberController.text);
                              families.honey = honeyController.text ?? '';
                              families.location = locationController.text ?? '';
                              getDB.updateFamilies(families);
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
                                      'Usuń Rodzinę!',
                                      textAlign: TextAlign.center,
                                    ),
                                    content: Text(
                                      'Czy chcesz usunąć rodzinę z listy?',
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
                                              .deleteFamilies(families.id);
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  );
                                });
                          },
                        ),
                        SizedBox(height: 400.0),
                      ],
                    )
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
