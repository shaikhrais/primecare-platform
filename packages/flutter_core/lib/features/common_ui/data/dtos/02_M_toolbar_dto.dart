// Layer: 02_MODELS_FOUNDATION
class ToolbarDto {
  final String id;
  final Map<String, dynamic> raw;

  ToolbarDto({required this.id, required this.raw});

  factory ToolbarDto.fromJson(Map<String, dynamic> json) {
    return ToolbarDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

