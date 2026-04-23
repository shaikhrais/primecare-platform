// Layer: 02_MODELS_FOUNDATION
class ToolbarLayout3Dto {
  final String id;
  final Map<String, dynamic> raw;

  ToolbarLayout3Dto({required this.id, required this.raw});

  factory ToolbarLayout3Dto.fromJson(Map<String, dynamic> json) {
    return ToolbarLayout3Dto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

