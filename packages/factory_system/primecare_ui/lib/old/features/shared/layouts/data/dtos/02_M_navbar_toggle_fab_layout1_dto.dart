// Layer: 02_MODELS_FOUNDATION
class NavbarToggleFabLayout1Dto {
  final String id;
  final Map<String, dynamic> raw;

  NavbarToggleFabLayout1Dto({required this.id, required this.raw});

  factory NavbarToggleFabLayout1Dto.fromJson(Map<String, dynamic> json) {
    return NavbarToggleFabLayout1Dto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
