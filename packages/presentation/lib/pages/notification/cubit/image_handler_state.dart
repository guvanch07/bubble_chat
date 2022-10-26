part of 'image_handler_cubit.dart';

@immutable
abstract class ImageHandlerState {}

class ImageHandlerInitial extends ImageHandlerState {}

class ImageHandlerLoading extends ImageHandlerState {}

class ImageHandlerLoaded extends ImageHandlerState {}

class ImageHandlerFailure extends ImageHandlerState {}
