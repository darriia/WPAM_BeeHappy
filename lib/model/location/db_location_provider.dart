import 'dart:io';

import 'package:beehappy/model/location/db_location_model.dart';
import 'package:beehappy/model/location/location_helper.dart';
import 'package:beehappy/model/location/location_loc.dart';
import 'package:beehappy/model/location/location_model.dart';
import 'package:flutter/material.dart';

class DBLocationProvider with ChangeNotifier {
  List<LocationModel> _locations = [];

  List<LocationModel> get locations => [..._locations];

  LocationModel findById(String id) {
    return _locations.firstWhere((location) => location.id == id);
  }

  LocationModel findByTitle(String title) {
    return _locations.firstWhere((location) => location.title == title);
  }

  Future addNewPlace(String title, File image, LocationLoc location) async {
    final String locationName = await LocationHelper.getLocationName(
        location.latitude, location.longitude);
    final LocationLoc updateLocation = LocationLoc(
        latitude: location.latitude,
        longitude: location.longitude,
        address: locationName);

    final newPlace = LocationModel(
      id: DateTime.now().toString(),
      title: title,
      image: image,
      location: updateLocation,
    );
    _locations.add(newPlace);

    notifyListeners();
    DBLocationModel.insert("PLACES", {
      "id": newPlace.id,
      "title": newPlace.title,
      "image": newPlace.image.path,
      "loc_latitude": newPlace.location.latitude,
      "loc_longitude": newPlace.location.longitude,
      "address": newPlace.location.address,
    });
  }

  Future deletePlace(String title) async {
    final location = findByTitle(title);
    _locations.remove(location);

    notifyListeners();
    DBLocationModel.delete("PLACES", location.id);
  }

  Future fetchPlaces() async {
    final List<Map<String, dynamic>> dataPlaces =
        await DBLocationModel.read("PLACES");

    _locations = dataPlaces
        .map((location) => LocationModel(
              id: location["id"],
              title: location["title"],
              image: File(location["image"]),
              location: LocationLoc(
                latitude: location["loc_latitude"],
                longitude: location["loc_longitude"],
                address: location["address"],
              ),
            ))
        .toList();
    notifyListeners();
  }
}
