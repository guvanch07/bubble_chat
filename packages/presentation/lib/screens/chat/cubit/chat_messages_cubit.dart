// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:domain/use_cases/get_messages_usecase.dart';
import 'package:domain/use_cases/send_text_message_usecase.dart';
import 'package:meta/meta.dart';
import 'package:domain/entities/text_messsage_entity.dart';

part 'chat_messages_state.dart';

class ChatMessagesCubit extends Cubit<ChatMessagesState> {
  ChatMessagesCubit(
    this.sendTextMessageUseCase,
    this.getMessageUseCase,
  ) : super(ChatMessagesInitial());

  final SendTextMessageUseCase sendTextMessageUseCase;
  final GetMessageUseCase getMessageUseCase;

  Future<void> getMessages(
      {required bool channel, required String channelId}) async {
    emit(ChatMessagesLoading());
    final streamResponse = getMessageUseCase.call(channel, channelId);
    streamResponse.listen((messages) {
      emit(ChatMessagesLoaded(messages: messages));
    });
  }

  Future<void> sendTextMessage(
      {required bool channel,
      required TextMessageEntity textMessageEntity,
      required String channelId}) async {
    try {
      await sendTextMessageUseCase.call(channel, textMessageEntity, channelId);
    } on SocketException catch (_) {
      emit(ChatMessagesFailure());
    } catch (_) {
      emit(ChatMessagesFailure());
    }
  }
}
