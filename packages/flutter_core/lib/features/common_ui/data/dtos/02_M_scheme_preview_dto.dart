// Layer: 02_MODELS_FOUNDATION
class SchemePreviewDto {
  final String id;
  final Map<String, dynamic> raw;

  SchemePreviewDto({required this.id, required this.raw});

  factory SchemePreviewDto.fromJson(Map<String, dynamic> json) {
    return SchemePreviewDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

