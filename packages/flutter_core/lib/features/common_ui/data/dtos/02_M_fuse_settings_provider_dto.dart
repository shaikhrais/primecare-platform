// Layer: 02_MODELS_FOUNDATION
class FuseSettingsProviderDto {
  final String id;
  final Map<String, dynamic> raw;

  FuseSettingsProviderDto({required this.id, required this.raw});

  factory FuseSettingsProviderDto.fromJson(Map<String, dynamic> json) {
    return FuseSettingsProviderDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

