import 'dart:io';

import 'package:beehappy/model/location/db_location_provider.dart';
import 'package:beehappy/model/location/location_loc.dart';
import 'package:beehappy/model/widgets/picture_widget.dart';
import 'package:beehappy/model/widgets/loc_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/theme.dart' as theme;

class AddLocation extends StatefulWidget {
  static const routeName = "/add-location";
  @override
  _AddLocationState createState() => _AddLocationState();
}

class _AddLocationState extends State<AddLocation> {
  final _titleController = TextEditingController();
  File _imagePicked;
  LocationLoc _locationPicked;

  void _selectImage(File imagePicked) {
    _imagePicked = imagePicked;
  }

  void _selectLocation(double latitude, double longitude) {
    _locationPicked = LocationLoc(latitude: latitude, longitude: longitude);
  }

  void _savePlace() {
    if (_titleController.text.isEmpty ||
        _imagePicked == null ||
        _locationPicked == null) {
      showCupertinoDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            'Uwaga!',
            textAlign: TextAlign.center,
          ),
          content: Text(
            'Musisz wpisać nazwę, dodać zdjęcie i wybrać lokalizację!',
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.yellow[50],
          elevation: 8.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          actions: <Widget>[
            OutlineButton(
              borderSide: BorderSide(color: Colors.black),
              shape: StadiumBorder(),
              child: Text(
                'Ok',
                style: TextStyle(
                    fontSize: 18.0,
                    letterSpacing: 1.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
      return;
    }
    Provider.of<DBLocationProvider>(context, listen: false)
        .addNewPlace(_titleController.text, _imagePicked, _locationPicked);
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.mainColor,
        centerTitle: true,
        title: Text("Dodaj Lokalizację"),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/${theme.bgImage}'),
          fit: BoxFit
              .cover, //zasłoni cały background, -> umiejscowienie image w bgc
        )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      TextField(
                        style: TextStyle(
                          color: theme.fontColor,
                          fontSize: 16.0,
                        ),
                        controller: _titleController,
                        textCapitalization: TextCapitalization.words,
                        decoration: InputDecoration(
                          labelText: "Nazwa Lokalizacji",
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
                        height: 16,
                      ),
                      PictureWidget(onImageSaved: _selectImage),
                      SizedBox(height: 16),
                      LocWidget(_selectLocation),
                    ],
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: _savePlace,
              child: SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add,
                      color: theme.fontColor,
                    ),
                    SizedBox(width: 8),
                    Text(
                      "Dodaj",
                      style: TextStyle(
                          color: theme.fontColor,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              style: ElevatedButton.styleFrom(
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  primary: theme.redColor,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
