import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/features/tasks/presentation/provider/photo_provider.dart';
import '../../domain/photo.dart';

class PhotoScreen extends ConsumerStatefulWidget {
  const PhotoScreen({super.key});

  @override
  _PhotoScreenState createState() => _PhotoScreenState();
}

class _PhotoScreenState extends ConsumerState<PhotoScreen> {
  @override
  void initState() {
    super.initState();
    // Asynchronously load photos when the widget is inserted into the tree
    WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(photoProvider.notifier).fetchPhotos();
        ref.read(photoProvider.notifier).loadPhotos();
    });
  }

  @override
  Widget build(BuildContext context) {
    final photoState = ref.watch(photoProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Photo Gallery"),
        backgroundColor: Colors.deepPurple,
      ),
      body: photoState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : photoState.errorMessage != null
              ? Text('Error: ${photoState.errorMessage}')
              : GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Number of columns
                    crossAxisSpacing: 4.0, // Horizontal space between items
                    mainAxisSpacing: 4.0,  // Vertical space between items
                  ),
                  itemCount: photoState.photos.length,
                  itemBuilder: (context, index) {
                    Photo photo = photoState.photos[index];
                    return Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      elevation: 5,
                      margin: const EdgeInsets.all(8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: GridTile(
                        footer: GridTileBar(
                          backgroundColor: Colors.black45,
                          title: Text(
                            photo.title,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                        child: Image.network(
                          photo.thumbnailUrl,
                          fit: BoxFit.cover, // Covers the area of the grid tile
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
