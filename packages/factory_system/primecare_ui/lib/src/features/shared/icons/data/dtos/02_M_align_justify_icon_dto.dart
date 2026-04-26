// Layer: 02_MODELS_FOUNDATION
class AlignJustifyIconDto {
  final String id;
  final Map<String, dynamic> raw;

  AlignJustifyIconDto({required this.id, required this.raw});

  factory AlignJustifyIconDto.fromJson(Map<String, dynamic> json) {
    return AlignJustifyIconDto(id: json['id']?.toString() ?? '', raw: json);
  }
}
