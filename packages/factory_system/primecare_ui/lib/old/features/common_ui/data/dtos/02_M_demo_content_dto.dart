// Layer: 02_MODELS_FOUNDATION
class DemoContentDto {
  final String id;
  final Map<String, dynamic> raw;

  DemoContentDto({required this.id, required this.raw});

  factory DemoContentDto.fromJson(Map<String, dynamic> json) {
    return DemoContentDto(id: json['id']?.toString() ?? '', raw: json);
  }
}
