import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import '../../model/theme.dart' as theme;

class PictureWidget extends StatefulWidget {
  final Function onImageSaved;

  PictureWidget({@required this.onImageSaved});
  @override
  _PictureWidgetState createState() => _PictureWidgetState();
}

class _PictureWidgetState extends State<PictureWidget> {
  File _storedImage;

  Future<void> takePhoto() async {
    final picker = ImagePicker();
    final imageFile = await picker.getImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    if (imageFile == null) return;
    setState(() {
      _storedImage = File(imageFile.path);
    });
    final appDirectory =
        await getApplicationDocumentsDirectory(); // Untuk mengambil direktori app
    final fileName = basename(
        imageFile.path); // Untuk menjadikan path image sebagai filename
    final savedImage = await _storedImage.copy(
        "${appDirectory.path}/$fileName"); // Menyalin gambar yang telah diambil ke direktori yang ditentukan
    widget.onImageSaved(savedImage);
  }

  Future<void> pickImageFromGallery() async {
    final picker = ImagePicker();
    final imageFile = await picker.getImage(
      source: ImageSource.gallery,
      maxWidth: 600,
    );
    if (imageFile == null) return;
    setState(() {
      _storedImage = File(imageFile.path);
    });

    widget.onImageSaved(_storedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 120,
            decoration: BoxDecoration(
              border: Border.all(
                color: theme.fontColor,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: _storedImage != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.file(
                      _storedImage,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  )
                : Text(
                    "Nie wybrano zdjęcia",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: theme.fontColor,
                      fontSize: 16.0,
                    ),
                  ),
            alignment: Alignment.center,
          ),
        ),
        Expanded(
          child: TextButton.icon(
            onPressed: () {
              _buildModalPickingImage(context);
            },
            icon: Icon(
              Icons.add_a_photo_outlined,
              color: theme.fontColor,
            ),
            label: Text("Dodaj zdjęcie",
                style: TextStyle(
                  color: theme.fontColor,
                  fontSize: 16.0,
                )),
          ),
        ),
      ],
    );
  }

  Future _buildModalPickingImage(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Dodaj zdjęcie",
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.close_rounded),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              SizedBox(height: 16),
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text("Użyj aparatu"),
                onTap: () {
                  Navigator.of(context).pop();
                  takePhoto();
                },
              ),
              ListTile(
                leading: Icon(Icons.image),
                title: Text("Wybierz zdjęcie z galerii"),
                onTap: () {
                  Navigator.of(context).pop();
                  pickImageFromGallery();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
