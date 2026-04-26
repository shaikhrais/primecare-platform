// Layer: 02_MODELS_FOUNDATION
class AlignRightIconDto {
  final String id;
  final Map<String, dynamic> raw;

  AlignRightIconDto({required this.id, required this.raw});

  factory AlignRightIconDto.fromJson(Map<String, dynamic> json) {
    return AlignRightIconDto(id: json['id']?.toString() ?? '', raw: json);
  }
}
