import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:domain/entities/user_entity.dart';
import 'package:domain/use_cases/get_all_users_usecase.dart';
import 'package:domain/use_cases/get_update_user_usecase.dart';
import 'package:domain/use_cases/create_one_to_one_chat_channel_usecase.dart';
import 'package:domain/entities/engage_user_entity.dart';
import 'package:domain/use_cases/add_to_my_chat_usecase.dart';
import 'package:domain/entities/my_chat_entity.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final GetAllUsersUseCase getAllUsersUseCase;
  final GetUpdateUserUseCase getUpdateUserUseCase;
  final CreateOneToOneChatChannelUseCase createOneToOneChatChannelUseCase;
  final AddToMyChatUseCase addToMyChatUseCase;
  UserCubit({
    required this.getAllUsersUseCase,
    required this.getUpdateUserUseCase,
    required this.createOneToOneChatChannelUseCase,
    required this.addToMyChatUseCase,
  }) : super(UserInitial());

  Future<void> getUsers() async {
    emit(UserLoading());
    final streamResponse = getAllUsersUseCase.call();
    streamResponse.listen((users) {
      emit(UserLoaded(users: users));
    });
  }

  Future<void> getUpdateUser({required UserEntity user}) async {
    try {
      await getUpdateUserUseCase.call(user);
    } on SocketException catch (_) {
      emit(UserFailure());
    } catch (_) {
      emit(UserFailure());
    }
  }

  Future<void> createOneToOneChatChannel(
      {required EngageUserEntity user}) async {
    try {
      await createOneToOneChatChannelUseCase(user);
    } on SocketException catch (_) {
      emit(UserFailure());
    } catch (_) {
      emit(UserFailure());
    }
  }

  Future<void> addToMyChat(MyChatEntity chatEntity) async {
    try {
      await addToMyChatUseCase(chatEntity);
    } on SocketException catch (_) {
      emit(UserFailure());
    } catch (_) {
      emit(UserFailure());
    }
  }
}
