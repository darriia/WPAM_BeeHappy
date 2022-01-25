import 'package:beehappy/model/bee_info/bee_info_model.dart';
import 'package:beehappy/model/bee_info/db_bee_info.dart';
import 'package:flutter/material.dart';
import '../../model/theme.dart' as theme;

class EditBeeInfo extends StatefulWidget {
  final BeeInfoModel beeInfo;
  EditBeeInfo(this.beeInfo);

  @override
  _EditBeeInfoState createState() => _EditBeeInfoState();
}

class _EditBeeInfoState extends State<EditBeeInfo> {
  final DBBeeInfo getDB = DBBeeInfo();

  // capture input from TextField
  var nameController = TextEditingController();
  var hivesNumberController = TextEditingController();
  var yearController = TextEditingController();
  var beekeeperController = TextEditingController();
  var beekeeperNumberController = TextEditingController();
  var characterController = TextEditingController();
  var districtController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    BeeInfoModel beeInfo = widget.beeInfo;
    // filled values to Form input field
    nameController.text = widget.beeInfo.name;
    hivesNumberController.text = widget.beeInfo.hivesNumber.toString();
    yearController.text = widget.beeInfo.year.toString();
    beekeeperController.text = widget.beeInfo.beekeeper;
    beekeeperNumberController.text = widget.beeInfo.beekeeperNumber.toString();
    characterController.text = widget.beeInfo.character;
    districtController.text = widget.beeInfo.district;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: theme.mainColor,
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/${theme.bgImage}'),
            fit: BoxFit
                .cover, //zasłoni cały background, -> umiejscowienie image w bgc
          )),
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
                          val.isEmpty ? 'Musisz dodać nazwę pasieki!' : null,
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
                      validator: (val) => val.isEmpty
                          ? 'Musisz dodać liczbę uli w pasiece!'
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
                      keyboardType: TextInputType.number,
                      controller: yearController,
                      decoration: InputDecoration(
                        labelText: 'Rok powstania',
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
                          ? 'Musisz dodać rok powstania pasieki!'
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
                      controller: beekeeperController,
                      decoration: InputDecoration(
                        labelText: 'Nazwisko pszczelarza',
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
                          ? 'Musisz dodać nazwisko pszczelarza!'
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
                      controller: beekeeperNumberController,
                      decoration: InputDecoration(
                        labelText: 'Numer rejestracyjny pszczelarza',
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
                          ? 'Musisz dodać numer rejestracyjny pszczelarza!'
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
                      controller: characterController,
                      decoration: InputDecoration(
                        labelText: 'Charakter hodowli pszczół',
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
                      keyboardType: TextInputType.number,
                      controller: districtController,
                      decoration: InputDecoration(
                        labelText: 'Nazwa obrębu ewidencyjnego',
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
                              beeInfo.name = nameController.text;
                              beeInfo.hivesNumber =
                                  int.parse(hivesNumberController.text);
                              beeInfo.year = int.parse(yearController.text);
                              beeInfo.beekeeper = beekeeperController.text;
                              beeInfo.beekeeperNumber = int.parse(
                                  beekeeperNumberController.text ?? '');
                              beeInfo.character =
                                  characterController.text ?? '';
                              beeInfo.district = districtController.text ?? '';
                              getDB.updateBeeInfo(beeInfo);
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
                                      'Usuń!',
                                      textAlign: TextAlign.center,
                                    ),
                                    content: Text(
                                      'Czy chcesz usunąć?',
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
                                          await getDB.deleteBeeInfo(beeInfo.id);
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
