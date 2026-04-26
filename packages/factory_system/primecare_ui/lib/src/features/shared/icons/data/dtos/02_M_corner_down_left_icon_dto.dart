// Layer: 02_MODELS_FOUNDATION
class CornerDownLeftIconDto {
  final String id;
  final Map<String, dynamic> raw;

  CornerDownLeftIconDto({required this.id, required this.raw});

  factory CornerDownLeftIconDto.fromJson(Map<String, dynamic> json) {
    return CornerDownLeftIconDto(id: json['id']?.toString() ?? '', raw: json);
  }
}
