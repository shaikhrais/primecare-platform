// Layer: 02_MODELS_FOUNDATION
class HrHiringDashboardAdapterDto {
  final String id;
  final Map<String, dynamic> raw;

  HrHiringDashboardAdapterDto({required this.id, required this.raw});

  factory HrHiringDashboardAdapterDto.fromJson(Map<String, dynamic> json) {
    return HrHiringDashboardAdapterDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
