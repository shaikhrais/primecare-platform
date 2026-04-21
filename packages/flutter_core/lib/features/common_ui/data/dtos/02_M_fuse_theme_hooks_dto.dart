// Layer: 02_MODELS_FOUNDATION
class FuseThemeHooksDto {
  final String id;
  final Map<String, dynamic> raw;

  FuseThemeHooksDto({required this.id, required this.raw});

  factory FuseThemeHooksDto.fromJson(Map<String, dynamic> json) {
    return FuseThemeHooksDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

