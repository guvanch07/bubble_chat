import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:domain/use_cases/get_my_chat_usecase.dart';
import 'package:domain/entities/my_chat_entity.dart';

part 'messages_state.dart';

class MessagesCubit extends Cubit<MessagesState> {
  MessagesCubit(this._getMyChatUseCase) : super(MessagesInitial());

  final GetMyChatUseCase _getMyChatUseCase;

  Future<void> getUsers(String uid) async {
    emit(MessagesLoading());
    final streamResponse = _getMyChatUseCase.call(uid);
    streamResponse.listen((chats) {
      emit(MessagesLoaded(myChats: chats));
    });
  }
}
