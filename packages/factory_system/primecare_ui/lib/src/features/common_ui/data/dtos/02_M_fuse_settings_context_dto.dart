// Layer: 02_MODELS_FOUNDATION
class FuseSettingsContextDto {
  final String id;
  final Map<String, dynamic> raw;

  FuseSettingsContextDto({required this.id, required this.raw});

  factory FuseSettingsContextDto.fromJson(Map<String, dynamic> json) {
    return FuseSettingsContextDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

