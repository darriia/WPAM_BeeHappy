import 'package:beehappy/model/photos/db_photos_provider.dart';
import 'package:beehappy/model/widgets/photos_widget.dart';
import 'package:beehappy/screens/photos_views/add_photos_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import '../../model/theme.dart' as theme;

class PhotosView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Zdjęcia", style: TextStyle(color: theme.fontColor)),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            color: theme.fontColor,
            onPressed: () {
              Navigator.of(context).pushNamed(AddPhotos.routeName);
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
          future: Provider.of<DBPhotosProvider>(context, listen: false)
              .fetchPhotos(),
          builder: (context, snapshot) => (snapshot.connectionState ==
                  ConnectionState.waiting)
              ? SpinKitFadingCircle(
                  color: theme.fontColor,
                )
              : Consumer<DBPhotosProvider>(
                  child: Center(
                    child: Text(
                      "Brak zdjęć do wyświetlenia",
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  builder: (context, photo, child) {
                    return (photo.photos.isEmpty)
                        ? child
                        : ListView.builder(
                            padding: const EdgeInsets.all(16),
                            itemCount: photo.photos.length,
                            itemBuilder: (BuildContext context, int index) {
                              final currentPhoto = photo.photos[index];
                              return PhotosWidget(currentPhoto: currentPhoto);
                            },
                          );
                  },
                ),
        ),
      ),
    );
  }
}
