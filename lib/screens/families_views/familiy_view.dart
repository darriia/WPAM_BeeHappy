import 'package:beehappy/model/families/db_family.dart';
import 'package:beehappy/model/families/family_model.dart';
import 'package:beehappy/screens/families_views/add_families.dart';
import 'package:beehappy/screens/families_views/edit_families.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/theme.dart' as theme;

class FamiliesMain extends StatefulWidget {
  @override
  _FamiliesMainState createState() => _FamiliesMainState();
}

class _FamiliesMainState extends State<FamiliesMain> {
  List<FamilyModel> families;

  @override
  Widget build(BuildContext context) {
    final getDB = Provider.of<DBFamily>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Rodziny', style: TextStyle(color: theme.fontColor)),
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
            future: getDB.getFamilies(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                families = snapshot.data;
                return ListView.builder(
                  itemCount: families.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Container(
                              height: 150.0,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                image: AssetImage('assets/hives.png'),
                                fit: BoxFit
                                    .fill, //zasłoni cały background, -> umiejscowienie image w bgc
                              )),
                            ),
                          ),
                        ),
                        Card(
                          color: theme.subColor2,
                          elevation: 6.0,
                          shape: StadiumBorder(),
                          child: ListTile(
                            leading: Icon(
                              Icons.radio_button_checked,
                              color: theme.fontColor,
                            ),
                            title: Text(
                              families[index].name,
                              style: TextStyle(
                                color: theme.fontColor,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Column(
                              children: [
                                Text(
                                  (families[index].hivesNumber.toString()),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  (families[index].honey),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  (families[index].location),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            trailing: Text(
                              families[index].litersNumber.toString(),
                              style: TextStyle(
                                color: theme.fontColor,
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        EditFamilies(families[index])),
                              );
                            },
                          ),
                        ),
                      ],
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
            MaterialPageRoute(builder: (context) => AddFamilies()),
          );
        },
        backgroundColor: Colors.yellow[50],
      ),
    );
  }
}
