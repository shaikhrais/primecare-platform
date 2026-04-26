// Layer: 02_MODELS_FOUNDATION
class NavbarStyle2Dto {
  final String id;
  final Map<String, dynamic> raw;

  NavbarStyle2Dto({required this.id, required this.raw});

  factory NavbarStyle2Dto.fromJson(Map<String, dynamic> json) {
    return NavbarStyle2Dto(id: json['id']?.toString() ?? '', raw: json);
  }
}
