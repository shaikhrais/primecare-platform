// Layer: 02_MODELS_FOUNDATION
class GoToDocBoxDto {
  final String id;
  final Map<String, dynamic> raw;

  GoToDocBoxDto({required this.id, required this.raw});

  factory GoToDocBoxDto.fromJson(Map<String, dynamic> json) {
    return GoToDocBoxDto(id: json['id']?.toString() ?? '', raw: json);
  }
}
