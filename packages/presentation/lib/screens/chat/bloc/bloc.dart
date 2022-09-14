import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:domain/models/contact.dart';

typedef _Snapshots = QuerySnapshot<Map<String, dynamic>>;
typedef _Document = DocumentReference<Map<String, dynamic>>;

class CreateUserBloc {
  final Sink<String?> userId;

  final Stream<Iterable<Contact>> contacts;

  void dispose() {
    userId.close();
  }

  const CreateUserBloc._({
    required this.userId,
    required this.contacts,
  });

  factory CreateUserBloc(FirebaseFirestore backend) {
    // user id
    final userId = BehaviorSubject<String?>();

    final Stream<Iterable<Contact>> contacts =
        userId.switchMap<_Snapshots>((userId) {
      if (userId == null) {
        return const Stream<_Snapshots>.empty();
      } else {
        return backend.collection(userId).snapshots();
      }
    }).map<Iterable<Contact>>((snapshots) sync* {
      for (final doc in snapshots.docs) {
        yield Contact.fromJson(
          doc.data(),
          id: doc.id,
        );
      }
    });

    return CreateUserBloc._(
      userId: userId,
      contacts: contacts,
    );
  }
}
