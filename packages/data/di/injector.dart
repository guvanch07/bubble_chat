import 'package:domain/repository/chat_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../repository/repository_impl.dart';

Future<void> injectDataModeule(GetIt sl) async {
  /// services
  sl.registerSingleton<FirebaseFirestore>(FirebaseFirestore.instance);
  sl.registerSingleton<FirebaseStorage>(FirebaseStorage.instance);

  ///repository
  sl.registerSingleton<IChatRepository>(
    ChatRepository(
      firebaseFirestore: sl.get<FirebaseFirestore>(),
      firebaseStorage: sl.get<FirebaseStorage>(),
    ),
  );
}
