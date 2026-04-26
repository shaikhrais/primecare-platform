// Layer: 02_MODELS_FOUNDATION
class FuseThemeDto {
  final String id;
  final Map<String, dynamic> raw;

  FuseThemeDto({required this.id, required this.raw});

  factory FuseThemeDto.fromJson(Map<String, dynamic> json) {
    return FuseThemeDto(id: json['id']?.toString() ?? '', raw: json);
  }
}
