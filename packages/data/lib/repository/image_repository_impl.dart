import 'dart:io';
import 'package:domain/repository/image_repository.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';

class ImageRepository implements IImageRepository {
  final FirebaseStorage storage;
  final ImagePicker imagePicker;
  ImageRepository({
    required this.storage,
    required this.imagePicker,
  });

  @override
  void dispose() {}

  @override
  Stream<List<Map<String, dynamic>>> loadImages() async* {
    List<Map<String, dynamic>> files = [];

    final ListResult result = await storage.ref().list();
    final List<Reference> allFiles = result.items;

    await Future.forEach<Reference>(
      allFiles,
      (file) async {
        final String fileUrl = await file.getDownloadURL();
        final FullMetadata fileMeta = await file.getMetadata();
        files.add(
          {
            "url": fileUrl,
            "path": file.fullPath,
            "uploaded_by": fileMeta.customMetadata?['uploaded_by'] ?? 'Nobody',
            "description":
                fileMeta.customMetadata?['description'] ?? 'No description'
          },
        );
      },
    );

    yield files;
  }

  @override
  Future<void> upload(String inputSource) async {
    final pickedImage = await pickerXfile(inputSource);
    final String fileName = basename(pickedImage!.path);
    File imageFile = File(pickedImage.path);

    try {
      // Uploading the selected image with some custom meta data
      await storage.ref(fileName).putFile(
            imageFile,
            SettableMetadata(
              customMetadata: {
                'uploaded_by': 'A bad guy',
                'description': 'Some description...'
              },
            ),
          );
    } on FirebaseException catch (error) {
      if (kDebugMode) {
        print(error);
      }
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }
  }

  Future<XFile?> pickerXfile(String inputSource) {
    XFile? pickedImage;
    if (pickedImage != null) {
      return imagePicker.pickImage(
          source: inputSource == 'camera'
              ? ImageSource.camera
              : ImageSource.gallery);
    } else {
      return Future.value(null);
    }
  }
}
