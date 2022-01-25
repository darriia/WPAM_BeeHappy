import 'package:beehappy/model/weather/weather_data_api.dart';
import 'package:beehappy/model/weather/weather_model.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:hexagon/hexagon.dart';
import '../model/theme.dart' as theme;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};

  final _cityTextController = TextEditingController();
  final _dataService = DataAPI();

  WeatherResponse _response;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //ustanienie paska na górze aplikacji w zależności od dnia i nocy
      backgroundColor: theme.bgColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text('BeeHappy', style: TextStyle(color: theme.fontColor)),
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
                Container(
                  width: 350,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (_response != null)
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.network(_response.iconUrl),
                              Text(
                                '${((_response.tempInfo.temperature - 32) / 1.8).toStringAsFixed(1)}°C',
                                style: TextStyle(
                                  fontSize: 40,
                                  color: theme.fontColor,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                                child: Text(
                                  'Wilgotność ${_response.tempInfo.humidity}%',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: theme.fontColor,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      Expanded(
                        child: Column(
                          children: [
                            Container(
                              width: 120,
                              child: TextField(
                                  style: TextStyle(
                                    color: theme.fontColor,
                                    fontSize: 20.0,
                                  ),
                                  controller: _cityTextController,
                                  decoration: InputDecoration(
                                      labelText: 'Miasto',
                                      labelStyle: TextStyle(
                                        fontSize: 16.0,
                                        color: theme.fontColor,
                                      )),
                                  textAlign: TextAlign.center),
                            ),
                            FlatButton(
                              onPressed: _search,
                              child: Text(
                                'Szukaj',
                                style: TextStyle(color: theme.fontColor),
                              ),
                              color: theme.subColor,
                              shape: StadiumBorder(),
                            ),
                          ],
                        ),
                      ),
                    ],
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
                              await Navigator.pushNamed(context, '/notes');
                        },
                        child: Text(
                          'Notatki',
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
                              await Navigator.pushNamed(context, '/hive');
                        },
                        child: Text(
                          'Moja pasieka',
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
                      color: theme.subColor3,
                      child: FlatButton(
                        height: 150.0,
                        onPressed: () async {
                          final url =
                              'https://www.pasieka24.pl/index.php/pl-pl/pasieka-czasopismo-dla-pszczelarzy/101-pasieka-1-2004/1195-pszczelarstwo-w-unii-europejskiej';
                          if (await canLaunch(url)) {
                            await launch(
                              url,
                              forceSafariVC: false,
                            );
                          }
                        },
                        child: Text(
                          'Normy Unijne',
                          textAlign: TextAlign.center,
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

  void _search() async {
    final response = await _dataService.getWeather(_cityTextController.text);
    setState(() => _response = response);
  }
}
