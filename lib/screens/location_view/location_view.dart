import 'package:beehappy/model/location/db_location_provider.dart';
import 'package:beehappy/model/widgets/location_widget.dart';
import 'package:beehappy/screens/location_view/add_location_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import '../../model/theme.dart' as theme;

class LocationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gdzie stawiasz ule?",
            style: TextStyle(color: theme.fontColor)),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddLocation.routeName);
            },
          ),
        ],
        backgroundColor: theme.mainColor,
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/${theme.bgImage}'),
          fit: BoxFit
              .cover, //zasłoni cały background, -> umiejscowienie image w bgc
        )),
        child: FutureBuilder(
          future: Provider.of<DBLocationProvider>(context, listen: false)
              .fetchPlaces(),
          builder: (context, snapshot) =>
              (snapshot.connectionState == ConnectionState.waiting)
                  ? SpinKitFadingCircle(
                      color: theme.fontColor,
                    )
                  : Consumer<DBLocationProvider>(
                      child: Center(
                        child: Text(
                          "Brak danych do wyświetlenia",
                          style: TextStyle(
                              color: theme.fontColor,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      builder: (context, location, child) {
                        return (location.locations.isEmpty)
                            ? child
                            : ListView.builder(
                                padding: const EdgeInsets.all(16),
                                itemCount: location.locations.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final currentLocation =
                                      location.locations[index];
                                  return LocationWidget(
                                      currentLocation: currentLocation);
                                },
                              );
                      },
                    ),
        ),
      ),
    );
  }
}
