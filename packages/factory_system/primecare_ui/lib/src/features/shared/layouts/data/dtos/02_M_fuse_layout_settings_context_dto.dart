// Layer: 02_MODELS_FOUNDATION
class FuseLayoutSettingsContextDto {
  final String id;
  final Map<String, dynamic> raw;

  FuseLayoutSettingsContextDto({required this.id, required this.raw});

  factory FuseLayoutSettingsContextDto.fromJson(Map<String, dynamic> json) {
    return FuseLayoutSettingsContextDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
