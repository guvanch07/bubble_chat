import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:domain/entities/image_params_entity.dart';
import 'package:presentation/pages/notification/cubit/image_handler_cubit.dart';
import 'package:domain/use_cases/image_upload_repository.dart';

class UploadingImage extends StatefulWidget {
  const UploadingImage({Key? key}) : super(key: key);

  @override
  State<UploadingImage> createState() => _UploadingImageState();
}

class _UploadingImageState extends State<UploadingImage> {
  FirebaseStorage storage = FirebaseStorage.instance;

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
        // Uploading the selected image with some custom meta data
        await storage.ref(fileName).putFile(
            imageFile,
            SettableMetadata(
                customMetadata: const ImageParms(
                        description: 'A bad guy',
                        uploadedBy: 'Some description...')
                    .toMap()));

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
  Stream<List<ImageParms>> _loadImages() async* {
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
            child: StreamBuilder<List<ImageParms>>(
              stream: _loadImages(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return ListView.builder(
                    itemCount: snapshot.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      final image = snapshot.data![index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: ListTile(
                          dense: false,
                          leading: Image.network(image.url ?? ""),
                          title: Text(image.uploadedBy),
                          subtitle: Text(image.description),
                          trailing: IconButton(
                            onPressed: () => _delete(image.path ?? ''),
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

class ImageStory extends StatelessWidget {
  const ImageStory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton.icon(
                  onPressed: () =>
                      context.read<ImageHandlerCubit>().uploadImage(
                            const UpLoadImageParams(
                              description: 'dssds',
                              source: 'camera',
                              uploadBy: 'by me',
                            ),
                          ),
                  icon: const Icon(Icons.camera),
                  label: const Text('camera')),
              ElevatedButton.icon(
                  onPressed: () =>
                      context.read<ImageHandlerCubit>().uploadImage(
                            const UpLoadImageParams(
                              description: 'sdsdsd',
                              source: 'gallery',
                              uploadBy: 'by me',
                            ),
                          ),
                  icon: const Icon(Icons.library_add),
                  label: const Text('Gallery')),
            ],
          ),
          BlocBuilder<ImageHandlerCubit, ImageHandlerState>(
            builder: (context, state) {
              if (state is ImageHandlerLoading) {
                return const CircularProgressIndicator.adaptive();
              }
              if (state is ImageHandlerLoaded) {
                ListView.builder(
                  itemCount: state.imageData.length,
                  itemBuilder: (context, index) {
                    final data = state.imageData[index];

                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: ListTile(
                        dense: false,
                        leading: Image.network(data.url ?? ""),
                        title: Text(data.uploadedBy),
                        subtitle: Text(data.description),
                        trailing: IconButton(
                          onPressed: () {},
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

              return const Text('empty');
            },
          )
        ],
      ),
    );
  }
}
