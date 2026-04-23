// Layer: 02_MODELS_FOUNDATION
class HeadingOneIconDto {
  final String id;
  final Map<String, dynamic> raw;

  HeadingOneIconDto({required this.id, required this.raw});

  factory HeadingOneIconDto.fromJson(Map<String, dynamic> json) {
    return HeadingOneIconDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

