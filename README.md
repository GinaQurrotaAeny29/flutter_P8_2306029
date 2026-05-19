# Praktikum Mobile – Pertemuan 8

## Consume API Menggunakan Flutter

## Deskripsi

Praktikum ini membahas tentang implementasi **Consume API** pada Flutter menggunakan package `http`. Aplikasi mengambil data dari **Open API** dan menampilkannya ke dalam aplikasi mobile menggunakan widget Flutter.

Pada project ini, aplikasi menampilkan:

* Daftar postingan dari API
* Daftar foto dari API
* Navigasi menggunakan tombol floating button horizontal di bagian bawah

## Tujuan Pembelajaran

Berdasarkan modul praktikum :

* Memahami konsep API dan REST API
* Memahami komunikasi client-server pada aplikasi mobile
* Menggunakan package HTTP pada Flutter
* Mengambil data dari Open API menggunakan method GET
* Mengubah data JSON menjadi object Dart
* Menampilkan data API ke dalam aplikasi Flutter

## Fitur Aplikasi

* Menampilkan daftar postingan dari API
* Menampilkan daftar foto dari API
* Menggunakan `FutureBuilder` untuk data asynchronous
* Parsing JSON ke model Dart
* Navigasi halaman menggunakan tombol floating button
* Floating button horizontal di bagian bawah layar
* Tampilan card modern dengan gambar thumbnail

## API yang Digunakan

* Post API:

```id="u20y1r"
https://jsonplaceholder.typicode.com/posts
```

* Photo API:

```id="m9k6ea"
https://picsum.photos/v2/list
```

## Tampilan Aplikasi

### Halaman Daftar Postingan

<img width="747" height="828" alt="image" src="https://github.com/user-attachments/assets/bf1c1c1d-2b36-49dd-acee-59f28c6d181a" />


### Halaman Daftar Foto

<img width="747" height="835" alt="image" src="https://github.com/user-attachments/assets/517b9f89-0d3c-4020-af66-26b6a1bb4168" />


## Struktur Project
lib/
├── main.dart
├── models/
│   ├── post_model.dart
│   └── photo_model.dart
├── services/
│   ├── post_service.dart
│   └── photo_service.dart
```

## Dependency

Tambahkan dependency berikut pada `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  http: ^1.2.0
```

Kemudian jalankan:

```bash
flutter pub get
```

## Konsep yang Digunakan

### 1. REST API

Menggunakan method GET untuk mengambil data dari server.

### 2. HTTP Package

Digunakan untuk melakukan request API:

```dart id="qv8rm5"
final response = await http.get(Uri.parse(url));
```

### 3. Model JSON

Contoh parsing JSON ke object Dart:

```dart id="o5f3ct"
factory PostModel.fromJson(Map<String, dynamic> json) {
  return PostModel(
    id: json['id'],
    title: json['title'],
    body: json['body'],
  );
}
```

### 4. FutureBuilder

Digunakan untuk menampilkan data asynchronous:

```dart id="dpkb5j"
FutureBuilder<List<PostModel>>(
  future: futurePosts,
  builder: (context, snapshot) {
    ...
  },
)
```

### 5. Floating Action Button Horizontal

Dua tombol floating dibuat horizontal menggunakan `Row`:

```dart id="jlwm0y"
Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    FloatingActionButton(...),
    SizedBox(width: 40),
    FloatingActionButton(...),
  ],
)
```


## Cara Kerja Aplikasi

* Aplikasi mengambil data dari Open API menggunakan HTTP GET
* Data JSON diubah menjadi object Dart menggunakan model
* `FutureBuilder` menampilkan loading saat data diambil
* Setelah data berhasil didapat:

  * Postingan ditampilkan dalam bentuk Card
  * Foto ditampilkan dengan thumbnail image
* Tombol floating digunakan untuk berpindah halaman:

  * Tombol Home → daftar postingan
  * Tombol Photo → daftar foto

## Teknologi yang Digunakan

* Flutter
* Dart
* HTTP Package
* REST API

## Kesimpulan

Pada praktikum ini dapat disimpulkan bahwa:

* Flutter dapat melakukan consume API dengan mudah menggunakan package `http`
* JSON dapat diubah menjadi object Dart menggunakan factory constructor
* `FutureBuilder` mempermudah pengelolaan data asynchronous
* REST API memungkinkan aplikasi mobile mengambil data realtime dari server
* UI Flutter dapat dibuat lebih interaktif dengan navigasi dan floating button
