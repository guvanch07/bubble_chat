import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:domain/core/helpers/firestore_helpers.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class MessageChat extends Equatable {
  const MessageChat({
    required this.idFrom,
    required this.idTo,
    required this.timestamp,
    required this.content,
    required this.type,
  });

  final String idFrom;
  final String idTo;
  final String timestamp;
  final String content;
  final int type;

  Map<String, dynamic> toJson() {
    return {
      FirestoreConstants.idFrom: idFrom,
      FirestoreConstants.idTo: idTo,
      FirestoreConstants.timestamp: timestamp,
      FirestoreConstants.content: content,
      FirestoreConstants.type: type,
    };
  }

  factory MessageChat.fromDocument(DocumentSnapshot doc) {
    String idFrom = doc.get(FirestoreConstants.idFrom);
    String idTo = doc.get(FirestoreConstants.idTo);
    String timestamp = doc.get(FirestoreConstants.timestamp);
    String content = doc.get(FirestoreConstants.content);
    int type = doc.get(FirestoreConstants.type);
    return MessageChat(
        idFrom: idFrom,
        idTo: idTo,
        timestamp: timestamp,
        content: content,
        type: type);
  }

  @override
  List<Object?> get props => [idFrom, idTo, timestamp, content, type];
}
