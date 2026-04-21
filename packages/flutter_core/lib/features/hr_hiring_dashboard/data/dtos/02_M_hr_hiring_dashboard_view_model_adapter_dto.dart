// Layer: 02_MODELS_FOUNDATION
class HrHiringDashboardViewModelAdapterDto {
  final String id;
  final Map<String, dynamic> raw;

  HrHiringDashboardViewModelAdapterDto({required this.id, required this.raw});

  factory HrHiringDashboardViewModelAdapterDto.fromJson(Map<String, dynamic> json) {
    return HrHiringDashboardViewModelAdapterDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
