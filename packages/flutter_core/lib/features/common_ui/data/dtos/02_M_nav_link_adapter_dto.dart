// Layer: 02_MODELS_FOUNDATION
class NavLinkAdapterDto {
  final String id;
  final Map<String, dynamic> raw;

  NavLinkAdapterDto({required this.id, required this.raw});

  factory NavLinkAdapterDto.fromJson(Map<String, dynamic> json) {
    return NavLinkAdapterDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
