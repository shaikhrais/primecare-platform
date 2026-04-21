// Layer: 02_MODELS_FOUNDATION
class HrHiringDashboardMapperDto {
  final String id;
  final Map<String, dynamic> raw;

  HrHiringDashboardMapperDto({required this.id, required this.raw});

  factory HrHiringDashboardMapperDto.fromJson(Map<String, dynamic> json) {
    return HrHiringDashboardMapperDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

