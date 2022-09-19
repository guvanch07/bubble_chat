// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'messages_cubit.dart';

@immutable
abstract class MessagesState {}

class MessagesInitial extends MessagesState {}

class MessagesLoading extends MessagesState {}

class MessagesLoaded extends MessagesState {
  final List<UserEntity> users;
  MessagesLoaded({
    required this.users,
  });
}

class MessagesFailture extends MessagesState {}
