import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:domain/use_cases/get_created_one_to_one_users.dart';
import 'package:domain/entities/user_entity.dart';

part 'messages_state.dart';

class MessagesCubit extends Cubit<MessagesState> {
  MessagesCubit(this._getCreatedOneToOneChats) : super(MessagesInitial());

  final GetCreatedOneToOneChatsUseCase _getCreatedOneToOneChats;

  Future<void> getUsers() async {
    emit(MessagesLoading());
    final streamResponse = _getCreatedOneToOneChats.call();
    streamResponse.listen((users) {
      emit(MessagesLoaded(users: users));
    });
  }
}
