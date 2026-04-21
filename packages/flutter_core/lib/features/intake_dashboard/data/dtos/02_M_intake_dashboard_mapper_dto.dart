// Layer: 02_MODELS_FOUNDATION
class IntakeDashboardMapperDto {
  final String id;
  final Map<String, dynamic> raw;

  IntakeDashboardMapperDto({required this.id, required this.raw});

  factory IntakeDashboardMapperDto.fromJson(Map<String, dynamic> json) {
    return IntakeDashboardMapperDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

