// Layer: 02_MODELS_FOUNDATION
class FuseSettingsDto {
  final String id;
  final Map<String, dynamic> raw;

  FuseSettingsDto({required this.id, required this.raw});

  factory FuseSettingsDto.fromJson(Map<String, dynamic> json) {
    return FuseSettingsDto(id: json['id']?.toString() ?? '', raw: json);
  }
}
