import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/photo.dart';

// Define the state that includes photo list, loading status, and error messages
class PhotoState {
  final List<Photo> photos;
  final bool isLoading;
  final String? errorMessage;

  PhotoState({required this.photos, this.isLoading = false, this.errorMessage});

  PhotoState copyWith({List<Photo>? photos, bool? isLoading, String? errorMessage}) {
    return PhotoState(
      photos: photos ?? this.photos,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

// Create a StateNotifier for managing the state
class PhotoNotifier extends StateNotifier<PhotoState> {
  PhotoNotifier() : super(PhotoState(photos: []));

   Future<void> fetchPhotos() async {
    try {
        log("Let's ");
      final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
      if (response.statusCode == 200) {
        List<dynamic> photoJson = json.decode(response.body);
        List<Photo> photos = photoJson.map((json) => Photo.fromJson(json)).toList();
        state = state.copyWith(photos: photos, isLoading: false);
        await savePhotos(photos.sublist(0, 20));
      } else {
        throw Exception('Failed to load photos');
      }
    } catch (e) {
      List<Photo> loadedPhotos = await loadPhotos(); // Load from SharedPreferences if there's an error
      state = state.copyWith(photos: loadedPhotos, isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> savePhotos(List<Photo> photos) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> photoStrings = photos.map((photo) => json.encode(photo.toJson())).toList();
    await prefs.setStringList('saved_photos', photoStrings);
  }

  Future<List<Photo>> loadPhotos() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? photoStrings = prefs.getStringList('saved_photos');
    if (photoStrings == null) return [];
    return photoStrings.map((str) => Photo.fromJson(json.decode(str))).toList();
  }
}

// Declare a provider for the PhotoNotifier
final photoProvider = StateNotifierProvider<PhotoNotifier, PhotoState>((ref) {
  return PhotoNotifier();
});



