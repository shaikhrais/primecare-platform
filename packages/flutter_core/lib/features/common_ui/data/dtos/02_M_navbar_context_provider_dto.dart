// Layer: 02_MODELS_FOUNDATION
class NavbarContextProviderDto {
  final String id;
  final Map<String, dynamic> raw;

  NavbarContextProviderDto({required this.id, required this.raw});

  factory NavbarContextProviderDto.fromJson(Map<String, dynamic> json) {
    return NavbarContextProviderDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

