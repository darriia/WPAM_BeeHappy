import 'dart:io';
import 'package:beehappy/model/photos/db_photos_model.dart';
import 'package:beehappy/model/photos/photos_model.dart';
import 'package:flutter/material.dart';

class DBPhotosProvider with ChangeNotifier {
  List<PhotosModel> _photos = [];

  List<PhotosModel> get photos => [..._photos];

  PhotosModel findById(String id) {
    return _photos.firstWhere((photo) => photo.id == id);
  }

  Future addNewPhoto(File image) async {
    final newPhoto = PhotosModel(
      id: DateTime.now().toString(),
      image: image,
    );
    _photos.add(newPhoto);

    notifyListeners();
    DBPhotosModel.insert("PHOTOS", {
      "id": newPhoto.id,
      "image": newPhoto.image.path,
    });
  }

  Future deletePhoto(String id) async {
    final photo = findById(id);
    _photos.remove(photo);

    notifyListeners();
    DBPhotosModel.delete("PHOTOS", photo.id);
  }

  Future fetchPhotos() async {
    final List<Map<String, dynamic>> dataPhotos =
        await DBPhotosModel.read("PHOTOS");

    _photos = dataPhotos
        .map((photo) => PhotosModel(
              id: photo["id"],
              image: File(photo["image"]),
            ))
        .toList();
    notifyListeners();
  }
}
