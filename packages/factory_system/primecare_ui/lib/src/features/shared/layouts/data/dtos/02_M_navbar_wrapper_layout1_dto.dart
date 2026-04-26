// Layer: 02_MODELS_FOUNDATION
class NavbarWrapperLayout1Dto {
  final String id;
  final Map<String, dynamic> raw;

  NavbarWrapperLayout1Dto({required this.id, required this.raw});

  factory NavbarWrapperLayout1Dto.fromJson(Map<String, dynamic> json) {
    return NavbarWrapperLayout1Dto(id: json['id']?.toString() ?? '', raw: json);
  }
}
