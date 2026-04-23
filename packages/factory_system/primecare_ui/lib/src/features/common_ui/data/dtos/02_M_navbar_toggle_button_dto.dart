// Layer: 02_MODELS_FOUNDATION
class NavbarToggleButtonDto {
  final String id;
  final Map<String, dynamic> raw;

  NavbarToggleButtonDto({required this.id, required this.raw});

  factory NavbarToggleButtonDto.fromJson(Map<String, dynamic> json) {
    return NavbarToggleButtonDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

