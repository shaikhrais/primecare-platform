// Layer: 02_MODELS_FOUNDATION
class FullScreenToggleDto {
  final String id;
  final Map<String, dynamic> raw;

  FullScreenToggleDto({required this.id, required this.raw});

  factory FullScreenToggleDto.fromJson(Map<String, dynamic> json) {
    return FullScreenToggleDto(id: json['id']?.toString() ?? '', raw: json);
  }
}
