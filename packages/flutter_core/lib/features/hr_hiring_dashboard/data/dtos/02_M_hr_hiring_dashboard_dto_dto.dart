// Layer: 02_MODELS_FOUNDATION
class HrHiringDashboardDtoDto {
  final String id;
  final Map<String, dynamic> raw;

  HrHiringDashboardDtoDto({required this.id, required this.raw});

  factory HrHiringDashboardDtoDto.fromJson(Map<String, dynamic> json) {
    return HrHiringDashboardDtoDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

