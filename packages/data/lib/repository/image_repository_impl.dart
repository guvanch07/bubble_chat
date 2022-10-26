import 'dart:io';
import 'package:domain/entities/image_params_entity.dart';
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
  Stream<List<ImageParms>> loadImages() async* {
    List<ImageParms> files = [];

    final ListResult result = await storage.ref().list();
    final List<Reference> allFiles = result.items;

    await Future.forEach<Reference>(
      allFiles,
      (file) async {
        final String fileUrl = await file.getDownloadURL();
        final FullMetadata fileMeta = await file.getMetadata();
        files.add(ImageParms(
          description:
              fileMeta.customMetadata?['description'] ?? 'No description',
          uploadedBy: fileMeta.customMetadata?['uploaded_by'] ?? 'Nobody',
          url: fileUrl,
          path: file.fullPath,
        ));
      },
    );

    yield files;
  }

  @override
  Future<void> upload({
    required String inputSource,
    required String uploadBy,
    required String description,
  }) async {
    final pickedImage = await pickerXfile(inputSource);
    final String fileName = basename(pickedImage!.path);
    File imageFile = File(pickedImage.path);

    try {
      await storage.ref(fileName).putFile(
          imageFile,
          SettableMetadata(
              customMetadata: const ImageParms(
                      description: 'A bad guy',
                      uploadedBy: 'Some description...')
                  .toMap()));
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
