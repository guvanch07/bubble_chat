import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:domain/use_cases/forgot_password_usecase.dart';
import 'package:domain/use_cases/get_create_current_user_usecase.dart';
import 'package:domain/use_cases/google_sign_in_usecase.dart';
import 'package:domain/use_cases/sign_in_usecase.dart';
import 'package:domain/use_cases/sign_up_usecase.dart';
import 'package:domain/entities/user_entity.dart';

part 'credential_state.dart';

class CredentialCubit extends Cubit<CredentialState> {
  final SignUpUseCase signUpUseCase;
  final SignInUseCase signInUseCase;
  final ForgotPasswordUseCase forgotPasswordUseCase;
  final GetCreateCurrentUserUseCase getCreateCurrentUserUseCase;
  final GoogleSignInUseCase googleSignInUseCase;

  CredentialCubit(
      {required this.googleSignInUseCase,
      required this.signUpUseCase,
      required this.signInUseCase,
      required this.forgotPasswordUseCase,
      required this.getCreateCurrentUserUseCase})
      : super(CredentialInitial());

  Future<void> forgotPassword({required String email}) async {
    try {
      await forgotPasswordUseCase.call(email);
    } on SocketException catch (_) {
      emit(CredentialFailure());
    } catch (_) {
      emit(CredentialFailure());
    }
  }

  Future<void> signInSubmit({
    required String email,
    required String password,
  }) async {
    emit(CredentialLoading());
    try {
      await signInUseCase.call(UserEntity(email: email, password: password));
      emit(CredentialSuccess());
    } on SocketException catch (_) {
      emit(CredentialFailure());
    } catch (_) {
      emit(CredentialFailure());
    }
  }

  Future<void> googleAuthSubmit() async {
    emit(CredentialLoading());
    try {
      await googleSignInUseCase.call();
      emit(CredentialSuccess());
    } on SocketException catch (_) {
      emit(CredentialFailure());
    } catch (_) {
      emit(CredentialFailure());
    }
  }

  Future<void> signUpSubmit({required UserEntity user}) async {
    emit(CredentialLoading());
    try {
      await signUpUseCase
          .call(UserEntity(email: user.email, password: user.password));
      await getCreateCurrentUserUseCase.call(user);
      emit(CredentialSuccess());
    } on SocketException catch (_) {
      emit(CredentialFailure());
    } catch (_) {
      emit(CredentialFailure());
    }
  }

  // File? _image;
  // String? _profileUrl;

  // Future<void> uploadImage()async{
  //   try {
  //     final pickedFile =
  //         await ImagePicker().pickImage(source: ImageSource.gallery);

  //     setState(() {
  //       if (pickedFile != null) {
  //         _image = File(pickedFile.path);
  //         StorageProviderRemoteDataSource.uploadFile(file: _image!)
  //             .then((value) {
  //           log("profileUrl");
  //           setState(() {
  //             _profileUrl = value;
  //           });
  //         });
  //       } else {
  //         log('No image selected.');
  //       }
  //     });
  //   } catch (e) {
  //     AppUIHelpers.toast("error $e");
  //   }
  // }

}
