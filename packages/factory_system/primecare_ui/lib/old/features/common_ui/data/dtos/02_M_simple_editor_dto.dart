// Layer: 02_MODELS_FOUNDATION
class SimpleEditorDto {
  final String id;
  final Map<String, dynamic> raw;

  SimpleEditorDto({required this.id, required this.raw});

  factory SimpleEditorDto.fromJson(Map<String, dynamic> json) {
    return SimpleEditorDto(id: json['id']?.toString() ?? '', raw: json);
  }
}
