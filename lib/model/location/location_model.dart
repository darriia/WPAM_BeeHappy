import 'dart:io';

import 'package:beehappy/model/location/location_loc.dart';
import 'package:flutter/material.dart';

class LocationModel {
  final String id;
  final String title;
  final File image;
  final LocationLoc location;

  LocationModel({
    @required this.id,
    @required this.title,
    @required this.image,
    @required this.location,
  });
}
