import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider/post_provider.dart';
import 'provider/photo_provider.dart';

import 'models/photo_model.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => PostProvider(),
        ),

        ChangeNotifierProvider(
          create: (_) => PhotoProvider(),
        ),
      ],

      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
      ),

      home: MainNavigation(),
    );
  }
}

class MainNavigation extends StatefulWidget {
  @override
  State<MainNavigation> createState() =>
      _MainNavigationState();
}

class _MainNavigationState
    extends State<MainNavigation> {

  int currentIndex = 0;

  final List<Widget> pages = [
    PostPage(),
    GalleryPage(),
  ];

  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,

      body: pages[currentIndex],

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),

        child: Container(
          height: 70,

          decoration: BoxDecoration(
            color: Colors.white,

            borderRadius:
                BorderRadius.circular(30),

            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                color:
                    Colors.black.withOpacity(0.2),
              ),
            ],
          ),

          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceAround,

            children: [

              IconButton(
                icon: Icon(
                  Icons.home,

                  color: currentIndex == 0
                      ? Colors.blue
                      : Colors.grey,
                ),

                onPressed: () => onTap(0),
              ),

              IconButton(
                icon: Icon(
                  Icons.image,

                  color: currentIndex == 1
                      ? Colors.blue
                      : Colors.grey,
                ),

                onPressed: () => onTap(1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PostPage extends StatefulWidget {
  @override
  State<PostPage> createState() =>
      _PostPageState();
}

class _PostPageState
    extends State<PostPage> {

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<PostProvider>().getPosts();
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Daftar Post"),
        backgroundColor:
            Colors.blueAccent,
      ),

      body: Consumer<PostProvider>(
        builder: (context, provider, child) {

          if (provider.isLoading) {
            return Center(
              child:
                  CircularProgressIndicator(),
            );
          }

          if (provider.posts.isEmpty) {
            return Center(
              child: Text("Data kosong"),
            );
          }

          return ListView.builder(
            padding: EdgeInsets.all(12),

            itemCount: provider.posts.length,

            itemBuilder: (context, index) {

              final post =
                  provider.posts[index];

              return Card(
                margin:
                    EdgeInsets.only(bottom: 12),

                shape:
                    RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(
                    12,
                  ),
                ),

                child: Padding(
                  padding: EdgeInsets.all(12),

                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment
                            .start,

                    children: [

                      Text(
                        post.title,

                        style: TextStyle(
                          fontSize: 18,

                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 8),

                      Text(post.body),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class GalleryPage extends StatefulWidget {
  @override
  State<GalleryPage> createState() =>
      _GalleryPageState();
}

class _GalleryPageState
    extends State<GalleryPage> {

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context
          .read<PhotoProvider>()
          .fetchPhotos();
    });
  }

  @override
  Widget build(BuildContext context) {

    final provider =
        context.watch<PhotoProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Daftar Foto"),
        backgroundColor: Colors.blueAccent,
      ),

      body: Builder(
        builder: (_) {

          if (provider.isLoading) {
            return Center(
              child:
                  CircularProgressIndicator(),
            );
          }

          if (provider
              .errorMessage
              .isNotEmpty) {

            return Center(
              child:
                  Text(provider.errorMessage),
            );
          }

          final List<PhotoModel> photos =
              provider.photos;

          return ListView.builder(
            padding: EdgeInsets.all(12),

            itemCount: photos.length,

            itemBuilder: (context, index) {

              final photo = photos[index];

              return Card(
                margin:
                    EdgeInsets.only(bottom: 12),

                shape:
                    RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(
                    12,
                  ),
                ),

                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment
                          .start,

                  children: [

                    Padding(
                      padding:
                          EdgeInsets.all(10),

                      child: Text(
                        photo.author,

                        style: TextStyle(
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ),

                    AspectRatio(
                      aspectRatio:
                          photo.width /
                              photo.height,

                      child: ClipRRect(
                        borderRadius:
                            BorderRadius
                                .vertical(
                          bottom:
                              Radius.circular(
                            12,
                          ),
                        ),

                        child: Image.network(
                          photo.downloadUrl,

                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}