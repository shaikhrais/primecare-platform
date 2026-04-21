// Layer: 02_MODELS_FOUNDATION
class HrHiringDashboardDtoAdapterDto {
  final String id;
  final Map<String, dynamic> raw;

  HrHiringDashboardDtoAdapterDto({required this.id, required this.raw});

  factory HrHiringDashboardDtoAdapterDto.fromJson(Map<String, dynamic> json) {
    return HrHiringDashboardDtoAdapterDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
