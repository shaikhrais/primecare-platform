// Layer: 02_MODELS_FOUNDATION
class FusePageCardedHeaderDto {
  final String id;
  final Map<String, dynamic> raw;

  FusePageCardedHeaderDto({required this.id, required this.raw});

  factory FusePageCardedHeaderDto.fromJson(Map<String, dynamic> json) {
    return FusePageCardedHeaderDto(id: json['id']?.toString() ?? '', raw: json);
  }
}
