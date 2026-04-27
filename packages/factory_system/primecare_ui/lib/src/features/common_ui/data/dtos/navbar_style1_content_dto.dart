// Layer: 02_MODELS_FOUNDATION
class NavbarStyle1ContentDto {
  final String id;
  final Map<String, dynamic> raw;

  NavbarStyle1ContentDto({required this.id, required this.raw});

  factory NavbarStyle1ContentDto.fromJson(Map<String, dynamic> json) {
    return NavbarStyle1ContentDto(id: json['id']?.toString() ?? '', raw: json);
  }
}
