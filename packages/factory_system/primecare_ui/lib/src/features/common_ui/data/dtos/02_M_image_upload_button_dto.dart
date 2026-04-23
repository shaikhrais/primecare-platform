// Layer: 02_MODELS_FOUNDATION
class ImageUploadButtonDto {
  final String id;
  final Map<String, dynamic> raw;

  ImageUploadButtonDto({required this.id, required this.raw});

  factory ImageUploadButtonDto.fromJson(Map<String, dynamic> json) {
    return ImageUploadButtonDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

