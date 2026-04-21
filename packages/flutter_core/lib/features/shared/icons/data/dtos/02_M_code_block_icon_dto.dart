// Layer: 02_MODELS_FOUNDATION
class CodeBlockIconDto {
  final String id;
  final Map<String, dynamic> raw;

  CodeBlockIconDto({required this.id, required this.raw});

  factory CodeBlockIconDto.fromJson(Map<String, dynamic> json) {
    return CodeBlockIconDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

