// Layer: 02_MODELS_FOUNDATION
class SettingsPanelDto {
  final String id;
  final Map<String, dynamic> raw;

  SettingsPanelDto({required this.id, required this.raw});

  factory SettingsPanelDto.fromJson(Map<String, dynamic> json) {
    return SettingsPanelDto(id: json['id']?.toString() ?? '', raw: json);
  }
}
