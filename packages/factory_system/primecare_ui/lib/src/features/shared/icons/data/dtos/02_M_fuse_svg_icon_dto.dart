// Layer: 02_MODELS_FOUNDATION
class FuseSvgIconDto {
  final String id;
  final Map<String, dynamic> raw;

  FuseSvgIconDto({required this.id, required this.raw});

  factory FuseSvgIconDto.fromJson(Map<String, dynamic> json) {
    return FuseSvgIconDto(id: json['id']?.toString() ?? '', raw: json);
  }
}
