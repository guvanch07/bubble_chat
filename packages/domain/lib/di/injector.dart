import 'package:domain/use_cases/add_to_my_chat_usecase.dart';
import 'package:domain/use_cases/create_group_usecase.dart';
import 'package:domain/use_cases/create_one_to_one_chat_channel_usecase.dart';
import 'package:domain/use_cases/forgot_password_usecase.dart';
import 'package:domain/use_cases/get_all_group_usecase.dart';
import 'package:domain/use_cases/get_all_users_usecase.dart';
import 'package:domain/use_cases/get_create_current_user_usecase.dart';
import 'package:domain/use_cases/get_created_one_to_one_users.dart';
import 'package:domain/use_cases/get_current_uid_usecase.dart';
import 'package:domain/use_cases/get_messages_usecase.dart';
import 'package:domain/use_cases/get_update_user_usecase.dart';
import 'package:domain/use_cases/google_sign_in_usecase.dart';
import 'package:domain/use_cases/is_sign_in_usecase.dart';
import 'package:domain/use_cases/join_group_usecase.dart';
import 'package:domain/use_cases/send_text_message_usecase.dart';
import 'package:domain/use_cases/sign_in_usecase.dart';
import 'package:domain/use_cases/sign_out_usecase.dart';
import 'package:domain/use_cases/sign_up_usecase.dart';
import 'package:domain/use_cases/update_group_usecase.dart';
import 'package:get_it/get_it.dart';

Future<void> injectDomainModeule(GetIt sl) async {
  /// services

  ///usecases
  sl.registerLazySingleton<GoogleSignInUseCase>(
      () => GoogleSignInUseCase(repository: sl.call()));
  sl.registerLazySingleton<ForgotPasswordUseCase>(
      () => ForgotPasswordUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetCreateCurrentUserUseCase>(
      () => GetCreateCurrentUserUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetCurrentUIDUseCase>(
      () => GetCurrentUIDUseCase(repository: sl.call()));
  sl.registerLazySingleton<IsSignInUseCase>(
      () => IsSignInUseCase(repository: sl.call()));
  sl.registerLazySingleton<SignInUseCase>(
      () => SignInUseCase(repository: sl.call()));
  sl.registerLazySingleton<SignUpUseCase>(
      () => SignUpUseCase(repository: sl.call()));
  sl.registerLazySingleton<SignOutUseCase>(
      () => SignOutUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetAllUsersUseCase>(
      () => GetAllUsersUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetUpdateUserUseCase>(
      () => GetUpdateUserUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetCreateGroupUseCase>(
      () => GetCreateGroupUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetAllGroupsUseCase>(
      () => GetAllGroupsUseCase(repository: sl.call()));
  sl.registerLazySingleton<JoinGroupUseCase>(
      () => JoinGroupUseCase(repository: sl.call()));
  sl.registerLazySingleton<UpdateGroupUseCase>(
      () => UpdateGroupUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetMessageUseCase>(
      () => GetMessageUseCase(repository: sl.call()));
  sl.registerLazySingleton<SendTextMessageUseCase>(
      () => SendTextMessageUseCase(repository: sl.call()));
  sl.registerLazySingleton<CreateOneToOneChatChannelUseCase>(
      () => CreateOneToOneChatChannelUseCase(repository: sl.call()));

  sl.registerLazySingleton<GetCreatedOneToOneChatsUseCase>(
      () => GetCreatedOneToOneChatsUseCase(repository: sl.call()));

  sl.registerLazySingleton<AddToMyChatUseCase>(
      () => AddToMyChatUseCase(repository: sl.call()));
}
