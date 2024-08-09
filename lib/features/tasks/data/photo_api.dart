import 'package:http/http.dart' as http;
import 'dart:convert';

import '../domain/photo.dart';
import '../presentation/widgets/shared_prefences.dart';

Future<List<Photo>> fetchPhotos() async {
  try {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    if (response.statusCode == 200) {
      List<dynamic> photoJson = json.decode(response.body);
      List<Photo> photos = photoJson.map((json) => Photo.fromJson(json)).toList();
      // Save only the first 20 photos
      await savePhotos(photos.sublist(0, 20));
      return photos;
    } else {
      throw Exception('Failed to load photos');
    }
  } catch (e) {
    // On error or no internet, load photos from SharedPreferences
    return await loadPhotos();
  }
}

