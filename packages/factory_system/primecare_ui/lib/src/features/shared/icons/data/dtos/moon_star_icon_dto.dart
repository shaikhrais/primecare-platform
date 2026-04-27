// Layer: 02_MODELS_FOUNDATION
class MoonStarIconDto {
  final String id;
  final Map<String, dynamic> raw;

  MoonStarIconDto({required this.id, required this.raw});

  factory MoonStarIconDto.fromJson(Map<String, dynamic> json) {
    return MoonStarIconDto(id: json['id']?.toString() ?? '', raw: json);
  }
}
