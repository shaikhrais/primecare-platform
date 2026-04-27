// Layer: 02_MODELS_FOUNDATION
class FusePageCardedDto {
  final String id;
  final Map<String, dynamic> raw;

  FusePageCardedDto({required this.id, required this.raw});

  factory FusePageCardedDto.fromJson(Map<String, dynamic> json) {
    return FusePageCardedDto(id: json['id']?.toString() ?? '', raw: json);
  }
}
