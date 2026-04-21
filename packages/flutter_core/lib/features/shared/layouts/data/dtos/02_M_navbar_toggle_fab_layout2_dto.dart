// Layer: 02_MODELS_FOUNDATION
class NavbarToggleFabLayout2Dto {
  final String id;
  final Map<String, dynamic> raw;

  NavbarToggleFabLayout2Dto({required this.id, required this.raw});

  factory NavbarToggleFabLayout2Dto.fromJson(Map<String, dynamic> json) {
    return NavbarToggleFabLayout2Dto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

