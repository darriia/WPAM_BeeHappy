import 'package:beehappy/model/location/location_helper.dart';
import 'package:beehappy/model/location/location_loc.dart';
import 'package:beehappy/screens/location_view/map_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:location/location.dart';
import 'package:latlong/latlong.dart';
import '../../model/theme.dart' as theme;

class LocWidget extends StatefulWidget {
  final Function onMapSelected;
  LocWidget(this.onMapSelected);

  @override
  _LocWidgetState createState() => _LocWidgetState();
}

class _LocWidgetState extends State<LocWidget> {
  String bgImage = 'bg.png';

  String _previewImageUrl;
  bool _isLoadImage = false;
  bool _isNavigateToMap = false;

  Future _getCurrentLocation() async {
    setState(() {
      _isLoadImage = true;
      _previewImageUrl = "";
    });
    final LocationData locationData = await Location().getLocation();
    setState(() {
      _isLoadImage = false;
      _previewImageUrl = LocationHelper.generatePreviewImage(
          latitude: locationData.latitude, longitude: locationData.longitude);
    });
    widget.onMapSelected(locationData.latitude, locationData.longitude);
  }

  Future _selectOnMap() async {
    setState(() {
      _isNavigateToMap = true;
    });
    final LocationData locationData = await Location().getLocation();
    final LatLng selectMap = await Navigator.of(context).push(MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => MapView(
        location: LocationLoc(
            latitude: locationData.latitude, longitude: locationData.longitude),
        isSelecting: true,
      ),
    ));
    if (selectMap == null) {
      return;
    }
    setState(() {
      _isNavigateToMap = false;
      _previewImageUrl = LocationHelper.generatePreviewImage(
        latitude: selectMap.latitude,
        longitude: selectMap.longitude,
      );
    });
    widget.onMapSelected(selectMap.latitude, selectMap.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              color: theme.fontColor,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          alignment: Alignment.center,
          child: (_previewImageUrl == null)
              ? Text(
                  "Nie wybrano lokalizacji",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: theme.fontColor,
                    fontSize: 16.0,
                  ),
                )
              : (_isLoadImage)
                  ? SpinKitFadingCircle(
                      color: theme.fontColor,
                    )
                  : Image.network(
                      _previewImageUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton.icon(
              icon: Icon(Icons.location_on, color: theme.fontColor),
              label: Text(
                "Twoja lokalizacja",
                style: TextStyle(
                  color: theme.fontColor,
                  fontSize: 14.0,
                ),
              ),
              onPressed: _getCurrentLocation,
            ),
            (_isNavigateToMap)
                ? SpinKitFadingCircle(
                    color: theme.fontColor,
                  )
                : TextButton.icon(
                    icon: Icon(Icons.map, color: theme.fontColor),
                    label: Text(
                      "Zaznacz na mapie",
                      style: TextStyle(
                        color: theme.fontColor,
                        fontSize: 14.0,
                      ),
                    ),
                    onPressed: _selectOnMap,
                  ),
          ],
        ),
      ],
    );
  }
}
