// Layer: 02_MODELS_FOUNDATION
class UseJwtAuthDto {
  final String id;
  final Map<String, dynamic> raw;

  UseJwtAuthDto({required this.id, required this.raw});

  factory UseJwtAuthDto.fromJson(Map<String, dynamic> json) {
    return UseJwtAuthDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

