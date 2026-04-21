// Layer: 02_MODELS_FOUNDATION
class CooDashboardDtoDto {
  final String id;
  final Map<String, dynamic> raw;

  CooDashboardDtoDto({required this.id, required this.raw});

  factory CooDashboardDtoDto.fromJson(Map<String, dynamic> json) {
    return CooDashboardDtoDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

