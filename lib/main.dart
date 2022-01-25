import 'package:beehappy/model/families/db_family.dart';
import 'package:beehappy/model/honey/db_honey.dart';
import 'package:beehappy/model/inspection/db_inspection.dart';
import 'package:beehappy/model/location/db_location_provider.dart';
import 'package:beehappy/model/photos/db_photos_provider.dart';
import 'package:beehappy/screens/bee_info_views/bee_info_view.dart';
import 'package:beehappy/screens/families_views/familiy_view.dart';
import 'package:beehappy/screens/hive_views/hive_main_view.dart';
import 'package:beehappy/screens/home.dart';
import 'package:beehappy/screens/honey_views/honey_view.dart';
import 'package:beehappy/screens/inspection_views/inspection_view.dart';
import 'package:beehappy/screens/location_view/add_location_view.dart';
import 'package:beehappy/screens/location_view/location_view.dart';
import 'package:beehappy/screens/notes_views/notes_view.dart';
import 'package:beehappy/screens/photos_views/add_photos_view.dart';
import 'package:beehappy/screens/photos_views/photos_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model/bee_info/db_bee_info.dart';

void main() {
  runApp(beehappy());
}

class beehappy extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DBBeeInfo()),
        ChangeNotifierProvider(create: (context) => DBFamily()),
        ChangeNotifierProvider(create: (context) => DBInspection()),
        ChangeNotifierProvider(create: (context) => DBHoney()),
        ChangeNotifierProvider(create: (context) => DBLocationProvider()),
        ChangeNotifierProvider(create: (context) => DBPhotosProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Bee happy',
        home: Home(),
        routes: {
          '/hive': (context) => HiveView(),
          '/beeinfo': (context) => BeeInfoMain(),
          '/families': (context) => FamiliesMain(),
          '/service': (context) => InspectionMain(),
          '/honey': (context) => HoneyMain(),
          '/notes': (context) => NotesMain(),
          '/location': (context) => LocationView(),
          '/add-location': (context) => AddLocation(),
          '/photos': (context) => PhotosView(),
          '/add-photos': (context) => AddPhotos(),
        },
      ),
    );
  }
}
