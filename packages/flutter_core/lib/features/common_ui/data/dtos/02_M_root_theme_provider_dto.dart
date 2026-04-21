// Layer: 02_MODELS_FOUNDATION
class RootThemeProviderDto {
  final String id;
  final Map<String, dynamic> raw;

  RootThemeProviderDto({required this.id, required this.raw});

  factory RootThemeProviderDto.fromJson(Map<String, dynamic> json) {
    return RootThemeProviderDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

