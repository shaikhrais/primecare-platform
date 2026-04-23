// Layer: 02_MODELS_FOUNDATION
class UndoRedoButtonDto {
  final String id;
  final Map<String, dynamic> raw;

  UndoRedoButtonDto({required this.id, required this.raw});

  factory UndoRedoButtonDto.fromJson(Map<String, dynamic> json) {
    return UndoRedoButtonDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

