// Layer: 02_MODELS_FOUNDATION
class FooterThemeDto {
  final String id;
  final Map<String, dynamic> raw;

  FooterThemeDto({required this.id, required this.raw});

  factory FooterThemeDto.fromJson(Map<String, dynamic> json) {
    return FooterThemeDto(id: json['id']?.toString() ?? '', raw: json);
  }
}
