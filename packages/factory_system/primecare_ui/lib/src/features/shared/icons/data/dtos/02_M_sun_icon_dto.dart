// Layer: 02_MODELS_FOUNDATION
class SunIconDto {
  final String id;
  final Map<String, dynamic> raw;

  SunIconDto({required this.id, required this.raw});

  factory SunIconDto.fromJson(Map<String, dynamic> json) {
    return SunIconDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

