// Layer: 02_MODELS_FOUNDATION
class SectionPreviewDto {
  final String id;
  final Map<String, dynamic> raw;

  SectionPreviewDto({required this.id, required this.raw});

  factory SectionPreviewDto.fromJson(Map<String, dynamic> json) {
    return SectionPreviewDto(id: json['id']?.toString() ?? '', raw: json);
  }
}
