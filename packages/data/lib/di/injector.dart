import 'package:data/repository/chat_repository_impl.dart';
import 'package:data/repository/image_repository_impl.dart';
import 'package:domain/repository/chat_repository.dart';
import 'package:domain/repository/image_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> injectDataModeule(GetIt sl) async {
  /// services
  sl.registerSingleton<FirebaseFirestore>(FirebaseFirestore.instance);
  sl.registerSingleton<FirebaseStorage>(FirebaseStorage.instance);
  sl.registerSingleton<SharedPreferences>(
      await SharedPreferences.getInstance());
  sl.registerSingleton<GoogleSignIn>(GoogleSignIn());
  sl.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);

  ///repository

  sl.registerSingleton<IFirestoreRepository>(
    ChatRepository(
      sl.get<FirebaseFirestore>(),
      sl.get<FirebaseAuth>(),
      sl.get<GoogleSignIn>(),
    ),
  );

  sl.registerSingleton<ImagePicker>(
    ImagePicker(),
  );

  sl.registerSingleton<IImageRepository>(
    ImageRepository(
      imagePicker: sl.get<ImagePicker>(),
      storage: sl.get<FirebaseStorage>(),
    ),
  );
}
