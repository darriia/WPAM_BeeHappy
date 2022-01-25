import 'package:beehappy/model/honey/db_honey.dart';
import 'package:beehappy/model/honey/honey_model.dart';
import 'package:flutter/material.dart';
import '../../model/theme.dart' as theme;

class EditHoney extends StatefulWidget {
  final HoneyModel honey;
  EditHoney(this.honey);

  @override
  _EditHoneyState createState() => _EditHoneyState();
}

class _EditHoneyState extends State<EditHoney> {
  final DBHoney getDB = DBHoney();

  // capture input from TextField
  var typeController = TextEditingController();
  var dateController = TextEditingController();
  var amountController = TextEditingController();
  var priceController = TextEditingController();
  var percentController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    HoneyModel honey = widget.honey;
    // filled values to Form input field
    typeController.text = widget.honey.type;
    dateController.text = widget.honey.date;
    amountController.text = widget.honey.amount.toString();
    priceController.text = widget.honey.price;
    percentController.text = widget.honey.percent.toString();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.mainColor,
        centerTitle: true,
        title: Text(widget.honey.type),
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
                      controller: dateController,
                      decoration: InputDecoration(
                        labelText: 'Data zbioru',
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
                      controller: amountController,
                      decoration: InputDecoration(
                        labelText: 'Liczba litrów',
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
                          val.isEmpty ? 'Musisz dodać liczbę litrów!' : null,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      style: TextStyle(
                        color: theme.fontColor,
                        fontSize: 16.0,
                      ),
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
                      validator: (val) => val.isEmpty
                          ? 'Musisz dodać cenę za litr miodu!'
                          : null,
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    TextFormField(
                        style: TextStyle(
                          color: theme.fontColor,
                          fontSize: 16.0,
                        ),
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
                        )),
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
                              honey.type = typeController.text;
                              honey.date = dateController.text;
                              honey.amount = int.parse(amountController.text);
                              honey.price = priceController.text;
                              honey.percent = int.parse(percentController.text);

                              getDB.updateHoney(honey);
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
                                      'Usuń Zbiór!',
                                      textAlign: TextAlign.center,
                                    ),
                                    content: Text(
                                      'Czy chcesz usunąć zbiór z listy?',
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
                                          await getDB.deleteHoney(honey.id);
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
