import 'package:beehappy/model/location/db_location_provider.dart';
import 'package:beehappy/model/location/location_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/theme.dart' as theme;

class LocationWidget extends StatefulWidget {
  LocationWidget({
    @required this.currentLocation,
  });

  final LocationModel currentLocation;

  @override
  _LocationWidgetState createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> {
  final _titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              child: Image.file(
                widget.currentLocation.image,
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
              child: Text(
                widget.currentLocation.title,
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.location_pin,
                    color: theme.fontColor,
                    size: 30.0,
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      widget.currentLocation.location.address,
                      style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.normal,
                          color: theme.fontColor),
                    ),
                  ),
                  IconButton(
                    color: theme.fontColor,
                    icon: Icon(Icons.delete, color: theme.fontColor),
                    iconSize: 30.0,
                    onPressed: () {
                      showDialog(
                          context: context,
                          barrierDismissible: true,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(
                                'Usuń Lokalizację!',
                                textAlign: TextAlign.center,
                              ),
                              content: Text(
                                'Czy chcesz usunąć lokalizację \n${widget.currentLocation.title} z listy?',
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
                                    'Tak',
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        letterSpacing: 1.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  onPressed: () async {
                                    await Provider.of<DBLocationProvider>(
                                            context,
                                            listen: false)
                                        .deletePlace(
                                            widget.currentLocation.title);
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
            ),
          ],
        ),
      ),
    );
  }
}
