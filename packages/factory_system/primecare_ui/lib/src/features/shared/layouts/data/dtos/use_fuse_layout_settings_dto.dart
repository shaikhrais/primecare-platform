// Layer: 02_MODELS_FOUNDATION
class UseFuseLayoutSettingsDto {
  final String id;
  final Map<String, dynamic> raw;

  UseFuseLayoutSettingsDto({required this.id, required this.raw});

  factory UseFuseLayoutSettingsDto.fromJson(Map<String, dynamic> json) {
    return UseFuseLayoutSettingsDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
