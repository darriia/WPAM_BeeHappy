import 'dart:io';

import 'package:flutter/material.dart';

class PhotosModel {
  final String id;
  final File image;

  PhotosModel({
    @required this.id,
    @required this.image,
  });
}
