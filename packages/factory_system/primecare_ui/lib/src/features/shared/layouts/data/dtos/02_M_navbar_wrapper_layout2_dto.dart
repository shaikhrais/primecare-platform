// Layer: 02_MODELS_FOUNDATION
class NavbarWrapperLayout2Dto {
  final String id;
  final Map<String, dynamic> raw;

  NavbarWrapperLayout2Dto({required this.id, required this.raw});

  factory NavbarWrapperLayout2Dto.fromJson(Map<String, dynamic> json) {
    return NavbarWrapperLayout2Dto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

