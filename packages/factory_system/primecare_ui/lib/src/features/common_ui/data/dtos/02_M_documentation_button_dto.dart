// Layer: 02_MODELS_FOUNDATION
class DocumentationButtonDto {
  final String id;
  final Map<String, dynamic> raw;

  DocumentationButtonDto({required this.id, required this.raw});

  factory DocumentationButtonDto.fromJson(Map<String, dynamic> json) {
    return DocumentationButtonDto(id: json['id']?.toString() ?? '', raw: json);
  }
}
