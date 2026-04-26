// Layer: 02_MODELS_FOUNDATION
class ToolbarLayout1Dto {
  final String id;
  final Map<String, dynamic> raw;

  ToolbarLayout1Dto({required this.id, required this.raw});

  factory ToolbarLayout1Dto.fromJson(Map<String, dynamic> json) {
    return ToolbarLayout1Dto(id: json['id']?.toString() ?? '', raw: json);
  }
}
