// Layer: 02_MODELS_FOUNDATION
class NavbarStyle2ContentDto {
  final String id;
  final Map<String, dynamic> raw;

  NavbarStyle2ContentDto({required this.id, required this.raw});

  factory NavbarStyle2ContentDto.fromJson(Map<String, dynamic> json) {
    return NavbarStyle2ContentDto(id: json['id']?.toString() ?? '', raw: json);
  }
}
