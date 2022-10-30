// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'image_handler_cubit.dart';

@immutable
abstract class ImageHandlerState {}

class ImageHandlerInitial extends ImageHandlerState {}

class ImageHandlerLoading extends ImageHandlerState {}

class ImageHandlerLoaded extends ImageHandlerState {
  final List<ImageParms> imageData;
  ImageHandlerLoaded({
    required this.imageData,
  });
}

class ImageHandlerFailure extends ImageHandlerState {}
