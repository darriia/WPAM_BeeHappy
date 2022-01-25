import 'package:beehappy/model/inspection/db_inspection.dart';
import 'package:beehappy/model/inspection/inspection_model.dart';
import 'package:beehappy/screens/inspection_views/add_inspection_view.dart';
import 'package:beehappy/screens/inspection_views/edit_inspection_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/theme.dart' as theme;

class InspectionMain extends StatefulWidget {
  @override
  _InspectionMainState createState() => _InspectionMainState();
}

class _InspectionMainState extends State<InspectionMain> {
  List<InspectionModel> inspection;

  @override
  Widget build(BuildContext context) {
    final getDB = Provider.of<DBInspection>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:
            Text('Lista Przeglądów', style: TextStyle(color: theme.fontColor)),
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
            future: getDB.getInspection(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                inspection = snapshot.data;
                return ListView.builder(
                  itemCount: inspection.length,
                  itemBuilder: (context, index) {
                    return Card(
                      // color: Theme.of(context).primaryColorLight,
                      color: theme.subColor2,
                      elevation: 6.0,
                      shape: StadiumBorder(),
                      child: ListTile(
                        leading: Icon(
                          Icons.construction_rounded,
                          color: theme.fontColor,
                        ),
                        title: Text(
                          inspection[index].name,
                          style: TextStyle(
                            color: theme.fontColor,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          (inspection[index].date),
                          style: TextStyle(
                            color: theme.fontColor,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    EditInspection(inspection[index])),
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
            MaterialPageRoute(builder: (context) => AddInspection()),
          );
        },
        backgroundColor: Colors.yellow[50],
      ),
    );
  }
}
