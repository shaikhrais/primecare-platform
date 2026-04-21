// Layer: 02_MODELS_FOUNDATION
class CooDashboardScreenDto {
  final String id;
  final Map<String, dynamic> raw;

  CooDashboardScreenDto({required this.id, required this.raw});

  factory CooDashboardScreenDto.fromJson(Map<String, dynamic> json) {
    return CooDashboardScreenDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

