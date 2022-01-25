import 'package:beehappy/model/honey/db_honey.dart';
import 'package:beehappy/model/honey/honey_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/theme.dart' as theme;

class AddHoney extends StatefulWidget {
  @override
  _AddHoneyState createState() => _AddHoneyState();
}

class _AddHoneyState extends State<AddHoney> {
  final DBHoney getDB = DBHoney();

  final FocusNode typeNode = FocusNode();
  final FocusNode dateNode = FocusNode();
  final FocusNode amountNode = FocusNode();
  final FocusNode priceNode = FocusNode();
  final FocusNode percentNode = FocusNode();

  // capture input from TextField
  var typeController = TextEditingController();
  var dateController = TextEditingController();
  var amountController = TextEditingController();
  var priceController = TextEditingController();
  var percentController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final getDB = Provider.of<DBHoney>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.mainColor,
        centerTitle: true,
        title: Text('Dodaj Miód ze zbioru',
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
                  controller: typeController,
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
                    FocusScope.of(context).requestFocus(dateNode);
                  },
                  validator: (val) =>
                      val.isEmpty ? 'Musisz dodać rodzaj miodu!' : null,
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
                    labelText: 'Data zbioru miodu',
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
                    FocusScope.of(context).requestFocus(amountNode);
                  },
                  validator: (val) =>
                      val.isEmpty ? 'Musisz dodać datę zbioru!' : null,
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  style: TextStyle(
                    color: theme.fontColor,
                    fontSize: 16.0,
                  ),
                  focusNode: amountNode,
                  controller: amountController,
                  decoration: InputDecoration(
                    labelText: 'Liczba litrów zebranego miodu',
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
                    FocusScope.of(context).requestFocus(priceNode);
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
                  focusNode: priceNode,
                  controller: priceController,
                  decoration: InputDecoration(
                    labelText: 'Cena za litr miodu',
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
                    FocusScope.of(context).requestFocus(percentNode);
                  },
                  validator: (val) =>
                      val.isEmpty ? 'Musisz dodać cenę za litr!' : null,
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  style: TextStyle(
                    color: theme.fontColor,
                    fontSize: 16.0,
                  ),
                  focusNode: percentNode,
                  controller: percentController,
                  decoration: InputDecoration(
                    labelText: 'Procent wody w miodzie',
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
                      HoneyModel newHoney = HoneyModel(
                        typeController.text,
                        dateController.text,
                        int.parse(amountController.text),
                        priceController.text,
                        int.parse(percentController.text ?? ''),
                      );

                      getDB.addHoney(newHoney).then((i) {
                        typeController.clear();
                        dateController.clear();
                        amountController.clear();
                        priceController.clear();
                        percentController.clear();
                        newHoney = null;
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
