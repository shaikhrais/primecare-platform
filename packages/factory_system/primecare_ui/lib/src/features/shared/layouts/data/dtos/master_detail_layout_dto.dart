// Layer: 02_MODELS_FOUNDATION
class MasterDetailLayoutDto {
  final String id;
  final Map<String, dynamic> raw;

  MasterDetailLayoutDto({required this.id, required this.raw});

  factory MasterDetailLayoutDto.fromJson(Map<String, dynamic> json) {
    return MasterDetailLayoutDto(id: json['id']?.toString() ?? '', raw: json);
  }
}
