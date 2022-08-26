import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

abstract class IChatRepository {
  UploadTask uploadFile(File image, String fileName);
  Future<void> updateDataFirestore(String collectionPath, String docPath,
      Map<String, dynamic> dataNeedUpdate);
  Stream<QuerySnapshot> getChatStream(String groupChatId, int limit);
  sendMessage(String content, int type, String groupChatId,
      String currentUserId, String peerId);
}
