// Layer: 02_MODELS_FOUNDATION
class SpacerDto {
  final String id;
  final Map<String, dynamic> raw;

  SpacerDto({required this.id, required this.raw});

  factory SpacerDto.fromJson(Map<String, dynamic> json) {
    return SpacerDto(id: json['id']?.toString() ?? '', raw: json);
  }
}
