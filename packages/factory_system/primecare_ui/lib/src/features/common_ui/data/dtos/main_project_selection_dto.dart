// Layer: 02_MODELS_FOUNDATION
class MainProjectSelectionDto {
  final String id;
  final Map<String, dynamic> raw;

  MainProjectSelectionDto({required this.id, required this.raw});

  factory MainProjectSelectionDto.fromJson(Map<String, dynamic> json) {
    return MainProjectSelectionDto(id: json['id']?.toString() ?? '', raw: json);
  }
}
