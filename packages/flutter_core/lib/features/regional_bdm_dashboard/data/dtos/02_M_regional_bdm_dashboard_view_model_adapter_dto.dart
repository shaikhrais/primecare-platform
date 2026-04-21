// Layer: 02_MODELS_FOUNDATION
class RegionalBdmDashboardViewModelAdapterDto {
  final String id;
  final Map<String, dynamic> raw;

  RegionalBdmDashboardViewModelAdapterDto({required this.id, required this.raw});

  factory RegionalBdmDashboardViewModelAdapterDto.fromJson(Map<String, dynamic> json) {
    return RegionalBdmDashboardViewModelAdapterDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
