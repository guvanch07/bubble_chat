import 'package:get_it/get_it.dart';
import 'package:presentation/pages/calls_page/cubit/group_cubit.dart';
import 'package:presentation/pages/contact_page/cubit/user_cubit.dart';
import 'package:presentation/pages/message/cubit/messages_cubit.dart';
import 'package:presentation/screens/auth/auth/auth_cubit.dart';
import 'package:presentation/screens/auth/credential_cubit/credential_cubit.dart';
import 'package:presentation/screens/chat/cubit/chat_messages_cubit.dart';

Future<void> injectPresentationModeule(GetIt sl) async {
  /// servicees

  /// blocs
  sl.registerFactory<GroupCubit>(
    () => GroupCubit(
      getCreateGroupUseCase: sl.get(),
      storage: sl.get(),
      getAllGroupsUseCase: sl.get(),
      joinGroupUseCase: sl.call(),
    ),
  );

  sl.registerFactory<AuthCubit>(
    () => AuthCubit(
      isSignInUseCase: sl.get(),
      signOutUseCase: sl.get(),
      getCurrentUIDUseCase: sl.get(),
    ),
  );

  sl.registerFactory<CredentialCubit>(
    () => CredentialCubit(
      forgotPasswordUseCase: sl.get(),
      getCreateCurrentUserUseCase: sl.get(),
      googleSignInUseCase: sl.get(),
      signInUseCase: sl.get(),
      signUpUseCase: sl.get(),
      storage: sl.get(),
    ),
  );
  sl.registerFactory<UserCubit>(
    () => UserCubit(
      getAllUsersUseCase: sl.get(),
      getUpdateUserUseCase: sl.get(),
      createOneToOneChatChannelUseCase: sl.get(),
      addToMyChatUseCase: sl.get(),
    ),
  );
  sl.registerFactory<MessagesCubit>(
    () => MessagesCubit(
      sl.get(),
    ),
  );
  sl.registerFactory<ChatMessagesCubit>(
    () => ChatMessagesCubit(
      sl.get(),
      sl.get(),
    ),
  );
}
