import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:hexagon/hexagon.dart';
import '../../model/theme.dart' as theme;

class HiveView extends StatefulWidget {
  @override
  _HiveViewState createState() => _HiveViewState();
}

class _HiveViewState extends State<HiveView> {
  Map data = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //ustanienie paska na górze aplikacji w zależności od dnia i nocy
      appBar: AppBar(
        centerTitle: true,
        title: Text('Moja pasieka', style: TextStyle(color: theme.fontColor)),
        backgroundColor: theme.mainColor,
        elevation: 0.0,
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
            child: Column(
              children: <Widget>[
                SizedBox(height: 25.0),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Container(
                      height: 150.0,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage('assets/logo.png'),
                      )),
                    ),
                  ),
                ),
                //Lista przycisków -> odniesień na inne screeny
                SizedBox(height: 25.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    HexagonWidget.flat(
                      width: 150.0,
                      color: theme.subColor,
                      child: FlatButton(
                        height: 150.0,
                        onPressed: () async {
                          dynamic result =
                              await Navigator.pushNamed(context, '/beeinfo');
                        },
                        child: Text(
                          'Informacje',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: theme.fontColor,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(width: 20.0),
                    HexagonWidget.flat(
                      width: 150.0,
                      color: theme.subColor2,
                      child: FlatButton(
                        height: 150.0,
                        onPressed: () async {
                          dynamic result =
                              await Navigator.pushNamed(context, '/families');
                        },
                        child: Text(
                          'Rodziny',
                          style: TextStyle(
                              color: theme.fontColor,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    HexagonWidget.flat(
                      width: 150.0,
                      color: theme.subColor2,
                      child: FlatButton(
                        height: 150.0,
                        onPressed: () async {
                          dynamic result =
                              await Navigator.pushNamed(context, '/honey');
                        },
                        child: Text(
                          'Miód',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: theme.fontColor,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(width: 20.0),
                    HexagonWidget.flat(
                      width: 150.0,
                      color: theme.subColor,
                      child: FlatButton(
                        height: 150.0,
                        onPressed: () async {
                          dynamic result =
                              await Navigator.pushNamed(context, '/service');
                        },
                        child: Text(
                          'Przegląd',
                          style: TextStyle(
                              color: theme.fontColor,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    HexagonWidget.flat(
                      width: 150.0,
                      color: theme.subColor,
                      child: FlatButton(
                        height: 150.0,
                        onPressed: () async {
                          dynamic result =
                              await Navigator.pushNamed(context, '/location');
                        },
                        child: Text(
                          'Lokalizacja\n Uli',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: theme.fontColor,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(width: 20.0),
                    HexagonWidget.flat(
                      width: 150.0,
                      color: theme.subColor2,
                      child: FlatButton(
                        height: 150.0,
                        onPressed: () async {
                          dynamic result =
                              await Navigator.pushNamed(context, '/photos');
                        },
                        child: Text(
                          'Zdjęcia',
                          style: TextStyle(
                              color: theme.fontColor,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 150.0),
              ],
            ),
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
