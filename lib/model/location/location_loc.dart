import 'package:flutter/material.dart';

class LocationLoc {
  final double latitude;
  final double longitude;
  final String address;

  const LocationLoc({
    @required this.latitude,
    @required this.longitude,
    this.address,
  });
}
