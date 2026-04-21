// Layer: 02_MODELS_FOUNDATION
class UseFuseSettingsDto {
  final String id;
  final Map<String, dynamic> raw;

  UseFuseSettingsDto({required this.id, required this.raw});

  factory UseFuseSettingsDto.fromJson(Map<String, dynamic> json) {
    return UseFuseSettingsDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

