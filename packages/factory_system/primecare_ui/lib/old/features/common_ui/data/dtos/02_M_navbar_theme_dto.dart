// Layer: 02_MODELS_FOUNDATION
class NavbarThemeDto {
  final String id;
  final Map<String, dynamic> raw;

  NavbarThemeDto({required this.id, required this.raw});

  factory NavbarThemeDto.fromJson(Map<String, dynamic> json) {
    return NavbarThemeDto(id: json['id']?.toString() ?? '', raw: json);
  }
}
