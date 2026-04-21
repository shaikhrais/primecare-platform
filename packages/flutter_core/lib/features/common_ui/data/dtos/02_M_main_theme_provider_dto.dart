// Layer: 02_MODELS_FOUNDATION
class MainThemeProviderDto {
  final String id;
  final Map<String, dynamic> raw;

  MainThemeProviderDto({required this.id, required this.raw});

  factory MainThemeProviderDto.fromJson(Map<String, dynamic> json) {
    return MainThemeProviderDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

