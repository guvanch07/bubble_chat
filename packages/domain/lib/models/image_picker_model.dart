// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class ImagePickerDataModel extends Equatable {
  final String path;
  final String? uploadBy;
  final String? description;
  const ImagePickerDataModel({
    required this.path,
    this.uploadBy,
    this.description,
  });

  ImagePickerDataModel copyWith({
    String? path,
    String? uploadBy,
    String? description,
  }) {
    return ImagePickerDataModel(
      path: path ?? this.path,
      uploadBy: uploadBy ?? this.uploadBy,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'path': path,
      'upload_by': uploadBy,
      'description': description,
    };
  }

  factory ImagePickerDataModel.fromMap(Map<String, dynamic> map) {
    return ImagePickerDataModel(
      path: map['path'] as String,
      uploadBy: map['upload_by'] != null ? map['upload_by'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ImagePickerDataModel.fromJson(String source) =>
      ImagePickerDataModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ImagePickerDataModel(path: $path, uploadBy: $uploadBy, description: $description)';

  @override
  bool operator ==(covariant ImagePickerDataModel other) {
    if (identical(this, other)) return true;

    return other.path == path &&
        other.uploadBy == uploadBy &&
        other.description == description;
  }

  @override
  int get hashCode => path.hashCode ^ uploadBy.hashCode ^ description.hashCode;

  @override
  List<Object?> get props => [];
}
