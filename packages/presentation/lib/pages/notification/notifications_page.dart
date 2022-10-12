import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class UploadingImage extends StatefulWidget {
  const UploadingImage({Key? key}) : super(key: key);

  @override
  State<UploadingImage> createState() => _UploadingImageState();
}

class _UploadingImageState extends State<UploadingImage> {
  FirebaseStorage storage = FirebaseStorage.instance;

  // Select and image from the gallery or take a picture with the camera
  // Then upload to Firebase Storage
  Future<void> _upload(String inputSource) async {
    final picker = ImagePicker();
    XFile? pickedImage;
    try {
      pickedImage = await picker.pickImage(
          source: inputSource == 'camera'
              ? ImageSource.camera
              : ImageSource.gallery,
          maxWidth: 1920);

      final String fileName = basename(pickedImage!.path);
      File imageFile = File(pickedImage.path);

      try {
        await storage.ref(fileName).putFile(
            imageFile,
            SettableMetadata(customMetadata: {
              'uploaded_by': 'A bad guy',
              'description': 'Some description...'
            }));

        // Refresh the UI
        setState(() {});
      } on FirebaseException catch (error) {
        if (kDebugMode) {
          print(error);
        }
      }
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }
  }

  // Retriew the uploaded images
  // This function is called when the app launches for the first time or when an image is uploaded or deleted
  Stream<Map<String, dynamic>> _loadImages() async* {
    Map<String, dynamic> files = {}; // list

    final ListResult result = await storage.ref().list();
    final List<Reference> allFiles = result.items;

    await Future.forEach<Reference>(allFiles, (file) async {
      final String fileUrl = await file.getDownloadURL();
      //final FullMetadata fileMeta = await file.getMetadata();
      files.addAll({
        // list add
        "url": fileUrl,
        "path": file.fullPath,
        //"uploaded_by": fileMeta.customMetadata?['uploaded_by'] ?? 'Nobody',
        // "description":
        //     fileMeta.customMetadata?['description'] ?? 'No description'
      });
    });

    yield files;
  }

  // Delete the selected image
  // This function is called when a trash icon is pressed
  Future<void> _delete(String ref) async {
    await storage.ref(ref).delete();
    // Rebuild the UI
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton.icon(
                  onPressed: () => _upload('camera'),
                  icon: const Icon(Icons.camera),
                  label: const Text('camera')),
              ElevatedButton.icon(
                  onPressed: () => _upload('gallery'),
                  icon: const Icon(Icons.library_add),
                  label: const Text('Gallery')),
            ],
          ),
          Expanded(
            child: StreamBuilder(
              stream: _loadImages(),
              builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return ListView.builder(
                    itemCount: snapshot.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      final Map<String, dynamic> image = snapshot.data![index];

                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: ListTile(
                          dense: false,
                          leading: Image.network(image['url']),
                          title: Text(image['uploaded_by']),
                          subtitle: Text(image['description']),
                          trailing: IconButton(
                            onPressed: () => _delete(image['path']),
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }

                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
