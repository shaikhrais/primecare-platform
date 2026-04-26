// Layer: 02_MODELS_FOUNDATION
class PaletteSelectorDto {
  final String id;
  final Map<String, dynamic> raw;

  PaletteSelectorDto({required this.id, required this.raw});

  factory PaletteSelectorDto.fromJson(Map<String, dynamic> json) {
    return PaletteSelectorDto(id: json['id']?.toString() ?? '', raw: json);
  }
}
