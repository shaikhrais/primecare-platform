// Layer: 02_MODELS_FOUNDATION
class NavbarPinToggleButtonDto {
  final String id;
  final Map<String, dynamic> raw;

  NavbarPinToggleButtonDto({required this.id, required this.raw});

  factory NavbarPinToggleButtonDto.fromJson(Map<String, dynamic> json) {
    return NavbarPinToggleButtonDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

