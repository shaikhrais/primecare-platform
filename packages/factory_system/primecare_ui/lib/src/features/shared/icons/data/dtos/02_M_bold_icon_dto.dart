// Layer: 02_MODELS_FOUNDATION
class BoldIconDto {
  final String id;
  final Map<String, dynamic> raw;

  BoldIconDto({required this.id, required this.raw});

  factory BoldIconDto.fromJson(Map<String, dynamic> json) {
    return BoldIconDto(id: json['id']?.toString() ?? '', raw: json);
  }
}
