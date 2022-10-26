class ImageParms {
  final String? url;
  final String? path;
  final String uploadedBy;
  final String description;
  const ImageParms({
    this.url,
    this.path,
    required this.uploadedBy,
    required this.description,
  });

  Map<String, String> toMap() {
    return <String, String>{
      'url': url ?? "",
      'path': path ?? "",
      'uploaded_by': uploadedBy,
      'description': description,
    };
  }

  factory ImageParms.fromMap(Map<String, dynamic> map) {
    return ImageParms(
      url: map['url'] as String,
      path: map['path'] as String,
      uploadedBy: map['uploaded_by'] as String,
      description: map['description'] as String,
    );
  }

  @override
  String toString() {
    return 'ImageParms(url: $url, path: $path, uploadedBy: $uploadedBy, description: $description)';
  }

  @override
  bool operator ==(covariant ImageParms other) {
    if (identical(this, other)) return true;

    return other.url == url &&
        other.path == path &&
        other.uploadedBy == uploadedBy &&
        other.description == description;
  }

  @override
  int get hashCode {
    return url.hashCode ^
        path.hashCode ^
        uploadedBy.hashCode ^
        description.hashCode;
  }
}
