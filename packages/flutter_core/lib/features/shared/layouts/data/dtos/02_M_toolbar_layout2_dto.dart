// Layer: 02_MODELS_FOUNDATION
class ToolbarLayout2Dto {
  final String id;
  final Map<String, dynamic> raw;

  ToolbarLayout2Dto({required this.id, required this.raw});

  factory ToolbarLayout2Dto.fromJson(Map<String, dynamic> json) {
    return ToolbarLayout2Dto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

