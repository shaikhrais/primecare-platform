// Layer: 02_MODELS_FOUNDATION
class FuseThemeSelectorDto {
  final String id;
  final Map<String, dynamic> raw;

  FuseThemeSelectorDto({required this.id, required this.raw});

  factory FuseThemeSelectorDto.fromJson(Map<String, dynamic> json) {
    return FuseThemeSelectorDto(id: json['id']?.toString() ?? '', raw: json);
  }
}
