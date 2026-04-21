// Layer: 02_MODELS_FOUNDATION
class CooDashboardMapperDto {
  final String id;
  final Map<String, dynamic> raw;

  CooDashboardMapperDto({required this.id, required this.raw});

  factory CooDashboardMapperDto.fromJson(Map<String, dynamic> json) {
    return CooDashboardMapperDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

