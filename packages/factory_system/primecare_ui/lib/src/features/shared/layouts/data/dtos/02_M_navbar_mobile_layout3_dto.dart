// Layer: 02_MODELS_FOUNDATION
class NavbarMobileLayout3Dto {
  final String id;
  final Map<String, dynamic> raw;

  NavbarMobileLayout3Dto({required this.id, required this.raw});

  factory NavbarMobileLayout3Dto.fromJson(Map<String, dynamic> json) {
    return NavbarMobileLayout3Dto(id: json['id']?.toString() ?? '', raw: json);
  }
}
