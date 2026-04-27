// Layer: 02_MODELS_FOUNDATION
class DisciplineLogFormDto {
  final String id;
  final Map<String, dynamic> raw;

  DisciplineLogFormDto({required this.id, required this.raw});

  factory DisciplineLogFormDto.fromJson(Map<String, dynamic> json) {
    return DisciplineLogFormDto(id: json['id']?.toString() ?? '', raw: json);
  }
}
