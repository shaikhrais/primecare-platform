// Layer: 02_MODELS_FOUNDATION
class NavbarStyle1Dto {
  final String id;
  final Map<String, dynamic> raw;

  NavbarStyle1Dto({required this.id, required this.raw});

  factory NavbarStyle1Dto.fromJson(Map<String, dynamic> json) {
    return NavbarStyle1Dto(id: json['id']?.toString() ?? '', raw: json);
  }
}
