// Layer: 02_MODELS_FOUNDATION
class QuickPanelDto {
  final String id;
  final Map<String, dynamic> raw;

  QuickPanelDto({required this.id, required this.raw});

  factory QuickPanelDto.fromJson(Map<String, dynamic> json) {
    return QuickPanelDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

