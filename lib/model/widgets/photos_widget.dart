import 'package:beehappy/model/photos/db_photos_provider.dart';
import 'package:beehappy/model/photos/photos_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/theme.dart' as theme;

class PhotosWidget extends StatefulWidget {
  PhotosWidget({
    @required this.currentPhoto,
  });

  final PhotosModel currentPhoto;

  @override
  _PhotosWidgetState createState() => _PhotosWidgetState();
}

class _PhotosWidgetState extends State<PhotosWidget> {
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
                widget.currentPhoto.image,
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
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
                              'Usuń Zdjęcie!',
                              textAlign: TextAlign.center,
                            ),
                            content: Text(
                              'Czy chcesz usunąć wybrane zdjęcie z listy?',
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
                                  await Provider.of<DBPhotosProvider>(context,
                                          listen: false)
                                      .deletePhoto(widget.currentPhoto.id);
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
          ],
        ),
      ),
    );
  }
}
