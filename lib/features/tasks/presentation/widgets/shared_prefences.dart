import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/features/tasks/domain/photo.dart';


Future<void> savePhotos(List<Photo> photos) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> photoStrings = photos.map((photo) => json.encode(photo.toJson())).toList();
  await prefs.setStringList('saved_photos', photoStrings);
}


Future<List<Photo>> loadPhotos() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String>? photoStrings = prefs.getStringList('saved_photos');
  return photoStrings?.map((photoString) => Photo.fromJson(json.decode(photoString))).toList() ?? [];
}
