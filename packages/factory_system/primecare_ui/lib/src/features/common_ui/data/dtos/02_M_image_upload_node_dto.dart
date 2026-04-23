// Layer: 02_MODELS_FOUNDATION
class ImageUploadNodeDto {
  final String id;
  final Map<String, dynamic> raw;

  ImageUploadNodeDto({required this.id, required this.raw});

  factory ImageUploadNodeDto.fromJson(Map<String, dynamic> json) {
    return ImageUploadNodeDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

