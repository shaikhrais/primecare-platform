// Layer: 02_MODELS_FOUNDATION
class NavbarWrapperLayout3Dto {
  final String id;
  final Map<String, dynamic> raw;

  NavbarWrapperLayout3Dto({required this.id, required this.raw});

  factory NavbarWrapperLayout3Dto.fromJson(Map<String, dynamic> json) {
    return NavbarWrapperLayout3Dto(id: json['id']?.toString() ?? '', raw: json);
  }
}
