// Layer: 02_MODELS_FOUNDATION
class HeadingThreeIconDto {
  final String id;
  final Map<String, dynamic> raw;

  HeadingThreeIconDto({required this.id, required this.raw});

  factory HeadingThreeIconDto.fromJson(Map<String, dynamic> json) {
    return HeadingThreeIconDto(id: json['id']?.toString() ?? '', raw: json);
  }
}
