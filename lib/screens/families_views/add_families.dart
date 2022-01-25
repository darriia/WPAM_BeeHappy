import 'package:beehappy/model/families/db_family.dart';
import 'package:beehappy/model/families/family_model.dart';
import 'package:flutter/material.dart';
import 'package:form_validators/form_validators.dart';
import 'package:provider/provider.dart';
import '../../model/theme.dart' as theme;

class AddFamilies extends StatefulWidget {
  @override
  _AddFamiliesState createState() => _AddFamiliesState();
}

class _AddFamiliesState extends State<AddFamilies> {
  final DBFamily getDB = DBFamily();

  final FocusNode nameNode = FocusNode();
  final FocusNode hivesNumberNode = FocusNode();
  final FocusNode honeyNode = FocusNode();
  final FocusNode locationNode = FocusNode();
  final FocusNode litersNumberNode = FocusNode();

  // capture input from TextField
  var nameController = TextEditingController();
  var hivesNumberController = TextEditingController();
  var honeyController = TextEditingController();
  var locationController = TextEditingController();
  var litersNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final getDB = Provider.of<DBFamily>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.mainColor,
        centerTitle: true,
        title: Text('Dodaj nową rodzinę',
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
                  onEditingComplete: () {
                    FocusScope.of(context).requestFocus(hivesNumberNode);
                  },
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
                  focusNode: hivesNumberNode,
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
                  onEditingComplete: () {
                    FocusScope.of(context).requestFocus(honeyNode);
                  },
                  validator: (val) =>
                      val.isEmpty ? 'Musisz dodać liczbę uli!' : null,
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  style: TextStyle(
                    color: theme.fontColor,
                    fontSize: 16.0,
                  ),
                  focusNode: honeyNode,
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
                  onEditingComplete: () {
                    FocusScope.of(context).requestFocus(locationNode);
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  style: TextStyle(
                    color: theme.fontColor,
                    fontSize: 16.0,
                  ),
                  focusNode: locationNode,
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
                  onEditingComplete: () {
                    FocusScope.of(context).requestFocus(litersNumberNode);
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  style: TextStyle(
                    color: theme.fontColor,
                    fontSize: 16.0,
                  ),
                  focusNode: litersNumberNode,
                  controller: litersNumberController,
                  decoration: InputDecoration(
                    labelText: 'Liczba litrów wprodukowanego miodu',
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
                RaisedButton(
                  color: theme.subColor2,
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
                      FamilyModel newFamilies = FamilyModel(
                          nameController.text,
                          int.parse(hivesNumberController.text),
                          honeyController.text ?? '',
                          locationController.text ?? '',
                          int.parse(litersNumberController.text));

                      getDB.addFamilies(newFamilies).then((i) {
                        nameController.clear();
                        hivesNumberController.clear();
                        honeyController.clear();
                        locationController.clear();
                        litersNumberController.clear();
                        newFamilies = null;
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
