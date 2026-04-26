// Layer: 02_MODELS_FOUNDATION
class UseAuthDto {
  final String id;
  final Map<String, dynamic> raw;

  UseAuthDto({required this.id, required this.raw});

  factory UseAuthDto.fromJson(Map<String, dynamic> json) {
    return UseAuthDto(id: json['id']?.toString() ?? '', raw: json);
  }
}
