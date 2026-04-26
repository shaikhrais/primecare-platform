// Layer: 02_MODELS_FOUNDATION
class HeadingTwoIconDto {
  final String id;
  final Map<String, dynamic> raw;

  HeadingTwoIconDto({required this.id, required this.raw});

  factory HeadingTwoIconDto.fromJson(Map<String, dynamic> json) {
    return HeadingTwoIconDto(id: json['id']?.toString() ?? '', raw: json);
  }
}
