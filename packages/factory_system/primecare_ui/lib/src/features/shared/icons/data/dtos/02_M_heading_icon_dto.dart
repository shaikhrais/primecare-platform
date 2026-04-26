// Layer: 02_MODELS_FOUNDATION
class HeadingIconDto {
  final String id;
  final Map<String, dynamic> raw;

  HeadingIconDto({required this.id, required this.raw});

  factory HeadingIconDto.fromJson(Map<String, dynamic> json) {
    return HeadingIconDto(id: json['id']?.toString() ?? '', raw: json);
  }
}
