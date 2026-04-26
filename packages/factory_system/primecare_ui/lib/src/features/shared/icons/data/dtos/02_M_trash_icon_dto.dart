// Layer: 02_MODELS_FOUNDATION
class TrashIconDto {
  final String id;
  final Map<String, dynamic> raw;

  TrashIconDto({required this.id, required this.raw});

  factory TrashIconDto.fromJson(Map<String, dynamic> json) {
    return TrashIconDto(id: json['id']?.toString() ?? '', raw: json);
  }
}
