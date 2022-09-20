// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'chat_messages_cubit.dart';

@immutable
abstract class ChatMessagesState {}

class ChatMessagesInitial extends ChatMessagesState {}

class ChatMessagesLoading extends ChatMessagesState {}

class ChatMessagesLoaded extends ChatMessagesState {
  final List<TextMessageEntity> messages;
  ChatMessagesLoaded({
    required this.messages,
  });
}

class ChatMessagesFailure extends ChatMessagesState {}
