// Layer: 02_MODELS_FOUNDATION
class NavbarMobileLayout2Dto {
  final String id;
  final Map<String, dynamic> raw;

  NavbarMobileLayout2Dto({required this.id, required this.raw});

  factory NavbarMobileLayout2Dto.fromJson(Map<String, dynamic> json) {
    return NavbarMobileLayout2Dto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

