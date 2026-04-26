// Layer: 02_MODELS_FOUNDATION
class FusePageSimpleDto {
  final String id;
  final Map<String, dynamic> raw;

  FusePageSimpleDto({required this.id, required this.raw});

  factory FusePageSimpleDto.fromJson(Map<String, dynamic> json) {
    return FusePageSimpleDto(id: json['id']?.toString() ?? '', raw: json);
  }
}
