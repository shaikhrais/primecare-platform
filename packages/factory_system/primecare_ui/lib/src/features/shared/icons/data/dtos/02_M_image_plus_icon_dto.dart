// Layer: 02_MODELS_FOUNDATION
class ImagePlusIconDto {
  final String id;
  final Map<String, dynamic> raw;

  ImagePlusIconDto({required this.id, required this.raw});

  factory ImagePlusIconDto.fromJson(Map<String, dynamic> json) {
    return ImagePlusIconDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

