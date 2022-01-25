import 'package:beehappy/model/honey/db_honey.dart';
import 'package:beehappy/model/honey/honey_model.dart';
import 'package:beehappy/screens/honey_views/add_honey_view.dart';
import 'package:beehappy/screens/honey_views/edit_honey_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/theme.dart' as theme;

class HoneyMain extends StatefulWidget {
  @override
  _HoneyMainState createState() => _HoneyMainState();
}

class _HoneyMainState extends State<HoneyMain> {
  List<HoneyModel> honey;

  @override
  Widget build(BuildContext context) {
    final getDB = Provider.of<DBHoney>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:
            Text('Ostatnie zbiory', style: TextStyle(color: theme.fontColor)),
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
          child: FutureBuilder(
            future: getDB.getHoney(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                honey = snapshot.data;
                return ListView.builder(
                  itemCount: honey.length,
                  itemBuilder: (context, index) {
                    return Card(
                      // color: Theme.of(context).primaryColorLight,
                      color: theme.subColor2,
                      elevation: 6.0,
                      shape: StadiumBorder(),
                      child: ListTile(
                        leading: Icon(
                          Icons.brightness_5,
                          color: theme.fontColor,
                        ),
                        title: Text(
                          honey[index].type,
                          style: TextStyle(
                            color: theme.fontColor,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          (honey[index].date),
                          style: TextStyle(
                            color: theme.redColor,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: Text(
                          (honey[index].price),
                          style: TextStyle(
                            color: theme.fontColor,
                            fontSize: 18.0,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditHoney(honey[index])),
                          );
                        },
                      ),
                    );
                  },
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.edit,
          color: theme.fontColor,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddHoney()),
          );
        },
        backgroundColor: Colors.yellow[50],
      ),
    );
  }
}
