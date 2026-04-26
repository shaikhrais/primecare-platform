// Layer: 02_MODELS_FOUNDATION
class FramedDemoDto {
  final String id;
  final Map<String, dynamic> raw;

  FramedDemoDto({required this.id, required this.raw});

  factory FramedDemoDto.fromJson(Map<String, dynamic> json) {
    return FramedDemoDto(id: json['id']?.toString() ?? '', raw: json);
  }
}
