// Layer: 02_MODELS_FOUNDATION
class HeadingButtonDto {
  final String id;
  final Map<String, dynamic> raw;

  HeadingButtonDto({required this.id, required this.raw});

  factory HeadingButtonDto.fromJson(Map<String, dynamic> json) {
    return HeadingButtonDto(id: json['id']?.toString() ?? '', raw: json);
  }
}
