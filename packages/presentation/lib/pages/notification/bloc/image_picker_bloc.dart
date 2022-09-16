import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:presentation/base/bloc_state.dart';
import 'package:presentation/core/heplers/extensions.dart';
import 'package:rxdart/rxdart.dart';
import 'package:domain/models/contact.dart';

typedef _Snapshots = QuerySnapshot<Map<String, dynamic>>;
typedef _Document = DocumentReference<Map<String, dynamic>>;


abstract class ImagePickerBase{
  factory ImagePickerBase() => _ImagePickerBase();
}

class _ImagePickerBase implements ImagePickerBase{


}


class ImagePickerBloc implements Bloc {
  final Sink<String?> userId;
  final Sink<Contact> createContact;
  final Sink<Contact> deleteContact;
  final Sink<void> deleteAllContacts;
  final Stream<Iterable<Contact>> contacts;
  final StreamSubscription<void> _createContactSubscription;
  final StreamSubscription<void> _deleteContactSubscription;
  final StreamSubscription<void> _deleteAllContactsSubscription;

@override
  void dispose() {
    userId.close();
    createContact.close();
    deleteContact.close();
    deleteAllContacts.close();
    _createContactSubscription.cancel();
    _deleteContactSubscription.cancel();
    _deleteAllContactsSubscription.cancel();
  }

  const ImagePickerBloc._({
    required this.userId,
    required this.createContact,
    required this.deleteContact,
    required this.contacts,
    required this.deleteAllContacts,
    required StreamSubscription<void> createContactSubscription,
    required StreamSubscription<void> deleteContactSubscription,
    required StreamSubscription<void> deleteAllContactsSubscription,
  })  : _createContactSubscription = createContactSubscription,
        _deleteContactSubscription = deleteContactSubscription,
        _deleteAllContactsSubscription = deleteAllContactsSubscription;

  factory ImagePickerBloc() {
    final backend = FirebaseFirestore.instance;
    final storage = FirebaseStorage.instance;

    ///
    
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

    // create contact

    final createContact = BehaviorSubject<Contact>();

    final StreamSubscription<void> createContactSubscription = createContact
        .switchMap((Contact contactToCreate) => userId
            .take(1)
            .unwrap()
            .asyncMap((userId) =>
                backend.collection(userId).add(contactToCreate.data)))
        .listen((event) {});

    // delete contact

    final deleteContact = BehaviorSubject<Contact>();

    final StreamSubscription<void> deleteContactSubscription = deleteContact
        .switchMap((Contact contactToDelete) => userId
            .take(1)
            .unwrap()
            .asyncMap((userId) =>
                backend.collection(userId).doc(contactToDelete.id).delete()))
        .listen((event) {});

    // delete all contacts

    final deleteAllContacts = BehaviorSubject<void>();

    final StreamSubscription<void> deleteAllContactsSubscription =
        deleteAllContacts
            .switchMap((_) => userId.take(1).unwrap())
            .asyncMap((userId) => backend.collection(userId).get())
            .switchMap((collection) => Stream.fromFutures(
                collection.docs.map((doc) => doc.reference.delete())))
            .listen((_) {});

    return ImagePickerBloc._(
      userId: userId,
      createContact: createContact,
      deleteContact: deleteContact,
      deleteAllContacts: deleteAllContacts,
      contacts: contacts,
      createContactSubscription: createContactSubscription,
      deleteContactSubscription: deleteContactSubscription,
      deleteAllContactsSubscription: deleteAllContactsSubscription,
    );
  }
}