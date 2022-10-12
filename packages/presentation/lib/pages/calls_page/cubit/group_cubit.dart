// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:domain/entities/group_entity.dart';
import 'package:domain/use_cases/create_group_usecase.dart';
import 'package:domain/use_cases/get_all_group_usecase.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

part 'group_state.dart';

class GroupCubit extends Cubit<GroupState> {
  final GetCreateGroupUseCase getCreateGroupUseCase;
  final FirebaseStorage storage;
  final GetAllGroupsUseCase getAllGroupsUseCase;

  GroupCubit({
    required this.getCreateGroupUseCase,
    required this.storage,
    required this.getAllGroupsUseCase,
  }) : super(GroupInitial());

  Future<void> createGroupe({required GroupEntity groupEntity}) async {
    try {
      await getCreateGroupUseCase.call(groupEntity);
    } on SocketException catch (_) {
      emit(GroupFailture());
    } catch (_) {
      emit(GroupFailture());
    }
  }

  Future<void> getGroups() async {
    emit(GroupLoading());
    final streamResponse = getAllGroupsUseCase.call();
    streamResponse.listen((groups) {
      emit(GroupLoaded(groups: groups));
    });
  }

  String? get profileImage => _profileUrl;

  String? _profileUrl;

  Future<void> uploadImage() async {
    final picker = ImagePicker();
    XFile? pickedImage;
    try {
      pickedImage =
          await picker.pickImage(source: ImageSource.gallery, maxWidth: 1920);

      final String fileName = basename(pickedImage!.path);
      File imageFile = File(pickedImage.path);

      try {
        // Uploading the selected image with some custom meta data
        await storage.ref(fileName).putFile(
              imageFile,
            );

        // Refresh the UI
        emit(GroupImageUpdate(image: _profileUrl = fileName));
      } on FirebaseException catch (error) {
        if (kDebugMode) {
          print(error);
        }
      }
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }
  }
}
