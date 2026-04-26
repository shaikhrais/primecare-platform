// Layer: 02_MODELS_FOUNDATION
class Redo2IconDto {
  final String id;
  final Map<String, dynamic> raw;

  Redo2IconDto({required this.id, required this.raw});

  factory Redo2IconDto.fromJson(Map<String, dynamic> json) {
    return Redo2IconDto(id: json['id']?.toString() ?? '', raw: json);
  }
}
