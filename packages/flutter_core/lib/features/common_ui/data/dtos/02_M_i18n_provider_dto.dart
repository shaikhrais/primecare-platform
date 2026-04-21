// Layer: 02_MODELS_FOUNDATION
class I18nProviderDto {
  final String id;
  final Map<String, dynamic> raw;

  I18nProviderDto({required this.id, required this.raw});

  factory I18nProviderDto.fromJson(Map<String, dynamic> json) {
    return I18nProviderDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

