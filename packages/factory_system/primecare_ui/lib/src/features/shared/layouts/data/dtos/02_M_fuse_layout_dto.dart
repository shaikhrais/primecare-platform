// Layer: 02_MODELS_FOUNDATION
class FuseLayoutDto {
  final String id;
  final Map<String, dynamic> raw;

  FuseLayoutDto({required this.id, required this.raw});

  factory FuseLayoutDto.fromJson(Map<String, dynamic> json) {
    return FuseLayoutDto(id: json['id']?.toString() ?? '', raw: json);
  }
}
