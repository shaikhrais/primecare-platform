// Layer: 02_MODELS_FOUNDATION
class DragAssignWidgetDto {
  final String id;
  final Map<String, dynamic> raw;

  DragAssignWidgetDto({required this.id, required this.raw});

  factory DragAssignWidgetDto.fromJson(Map<String, dynamic> json) {
    return DragAssignWidgetDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

