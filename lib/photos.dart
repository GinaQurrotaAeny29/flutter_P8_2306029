import 'package:flutter/material.dart';

import 'models/photo_model.dart';
import 'services/photo_service.dart';

class PhotoPage extends StatefulWidget {
  @override
  State<PhotoPage> createState() =>
      _PhotoPageState();
}

class _PhotoPageState
    extends State<PhotoPage> {

  late Future<List<PhotoModel>>
      futurePhotos;

  @override
  void initState() {
    super.initState();

    futurePhotos =
        PhotoService.getPhotos();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Daftar Foto",

          style: TextStyle(
            color: Colors.white,

            fontWeight:
                FontWeight.bold,

            fontSize: 20,
          ),
        ),

        backgroundColor:
            Colors.lightBlue,

        automaticallyImplyLeading:
            false,
      ),

      body: FutureBuilder<
          List<PhotoModel>>(
        future: futurePhotos,

        builder: (context, snapshot) {

          if (snapshot.hasData) {

            final photos =
                snapshot.data!;

            return ListView.builder(
              itemCount: photos.length,

              itemBuilder:
                  (context, index) {

                final photo =
                    photos[index];

                return Card(
                  margin:
                      const EdgeInsets.all(
                    10,
                  ),

                  child: ListTile(
                    title:
                        Text(photo.author),

                    subtitle:
                        Image.network(
                      photo.downloadUrl,

                      height: 200,

                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            );
          }

          else if (snapshot.hasError) {

            return Center(
              child: Text(
                'Error: ${snapshot.error}',
              ),
            );
          }

          else {

            return Center(
              child:
                  CircularProgressIndicator(),
            );
          }
        },
      ),

      floatingActionButton: Row(
        mainAxisAlignment:
            MainAxisAlignment
                .spaceAround,

        children: [

          FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                '/',
              );
            },

            child: Icon(Icons.home),
          ),

          FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                '/photos',
              );
            },

            child: Icon(Icons.photo),
          ),
        ],
      ),
    );
  }
}