// Layer: 02_MODELS_FOUNDATION
class StrikeIconDto {
  final String id;
  final Map<String, dynamic> raw;

  StrikeIconDto({required this.id, required this.raw});

  factory StrikeIconDto.fromJson(Map<String, dynamic> json) {
    return StrikeIconDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

