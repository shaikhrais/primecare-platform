// Layer: 02_MODELS_FOUNDATION
class HrHiringDashboardViewModelDto {
  final String id;
  final Map<String, dynamic> raw;

  HrHiringDashboardViewModelDto({required this.id, required this.raw});

  factory HrHiringDashboardViewModelDto.fromJson(Map<String, dynamic> json) {
    return HrHiringDashboardViewModelDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

