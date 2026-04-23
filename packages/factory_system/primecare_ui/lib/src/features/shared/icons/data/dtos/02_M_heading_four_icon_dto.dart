// Layer: 02_MODELS_FOUNDATION
class HeadingFourIconDto {
  final String id;
  final Map<String, dynamic> raw;

  HeadingFourIconDto({required this.id, required this.raw});

  factory HeadingFourIconDto.fromJson(Map<String, dynamic> json) {
    return HeadingFourIconDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

