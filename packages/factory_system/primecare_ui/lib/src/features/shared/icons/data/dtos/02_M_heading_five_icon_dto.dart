// Layer: 02_MODELS_FOUNDATION
class HeadingFiveIconDto {
  final String id;
  final Map<String, dynamic> raw;

  HeadingFiveIconDto({required this.id, required this.raw});

  factory HeadingFiveIconDto.fromJson(Map<String, dynamic> json) {
    return HeadingFiveIconDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

