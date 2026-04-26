// Layer: 02_MODELS_FOUNDATION
class NavbarLayout2Dto {
  final String id;
  final Map<String, dynamic> raw;

  NavbarLayout2Dto({required this.id, required this.raw});

  factory NavbarLayout2Dto.fromJson(Map<String, dynamic> json) {
    return NavbarLayout2Dto(id: json['id']?.toString() ?? '', raw: json);
  }
}
