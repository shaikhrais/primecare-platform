// Layer: 02_MODELS_FOUNDATION
class NavbarLayout3Dto {
  final String id;
  final Map<String, dynamic> raw;

  NavbarLayout3Dto({required this.id, required this.raw});

  factory NavbarLayout3Dto.fromJson(Map<String, dynamic> json) {
    return NavbarLayout3Dto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

