import 'package:domain/entities/image_params_entity.dart';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:domain/use_cases/image_upload_repository.dart';
import 'package:meta/meta.dart';

part 'image_handler_state.dart';

class ImageHandlerCubit extends Cubit<ImageHandlerState> {
  ImageHandlerCubit(
    this._loadImagesUseCase,
    this._upLoadImagesUseCase,
  ) : super(ImageHandlerInitial());
  final LoadImagesUseCase _loadImagesUseCase;
  final UploadImagesUseCase _upLoadImagesUseCase;

  Future<void> uploadImage(UpLoadImageParams params) async {
    try {
      await _upLoadImagesUseCase(params);
    } on SocketException catch (_) {
      emit(ImageHandlerFailure());
    } catch (_) {
      emit(ImageHandlerFailure());
    }
  }

  Future<void> loadImages() async {
    emit(ImageHandlerLoading());
    final streamResponse = _loadImagesUseCase();
    streamResponse
        .listen((images) => emit(ImageHandlerLoaded(imageData: images)));
  }
}
