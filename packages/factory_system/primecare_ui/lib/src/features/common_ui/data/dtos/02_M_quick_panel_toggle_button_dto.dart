// Layer: 02_MODELS_FOUNDATION
class QuickPanelToggleButtonDto {
  final String id;
  final Map<String, dynamic> raw;

  QuickPanelToggleButtonDto({required this.id, required this.raw});

  factory QuickPanelToggleButtonDto.fromJson(Map<String, dynamic> json) {
    return QuickPanelToggleButtonDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

