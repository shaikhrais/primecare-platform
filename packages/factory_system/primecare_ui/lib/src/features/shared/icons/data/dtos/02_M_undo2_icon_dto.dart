// Layer: 02_MODELS_FOUNDATION
class Undo2IconDto {
  final String id;
  final Map<String, dynamic> raw;

  Undo2IconDto({required this.id, required this.raw});

  factory Undo2IconDto.fromJson(Map<String, dynamic> json) {
    return Undo2IconDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

