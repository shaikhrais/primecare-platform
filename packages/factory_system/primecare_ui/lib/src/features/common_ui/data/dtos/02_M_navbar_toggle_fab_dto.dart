// Layer: 02_MODELS_FOUNDATION
class NavbarToggleFabDto {
  final String id;
  final Map<String, dynamic> raw;

  NavbarToggleFabDto({required this.id, required this.raw});

  factory NavbarToggleFabDto.fromJson(Map<String, dynamic> json) {
    return NavbarToggleFabDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

