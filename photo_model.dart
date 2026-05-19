class PhotoModel {
  final String id;
  final String author;
  final String downloadUrl;

  PhotoModel({required this.id, required this.author, required this.downloadUrl});

  factory PhotoModel.fromJson(Map<String, dynamic> json) {
    return PhotoModel(
      id: json['id'].toString(),
      author: json['author'],
      downloadUrl: json['download_url'],
    );
  }

  String get thumbnailUrl => 'https://picsum.photos/id/$id/100/100';
}