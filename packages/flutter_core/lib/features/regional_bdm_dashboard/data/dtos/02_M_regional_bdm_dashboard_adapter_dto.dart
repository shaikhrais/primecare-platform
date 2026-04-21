// Layer: 02_MODELS_FOUNDATION
class RegionalBdmDashboardAdapterDto {
  final String id;
  final Map<String, dynamic> raw;

  RegionalBdmDashboardAdapterDto({required this.id, required this.raw});

  factory RegionalBdmDashboardAdapterDto.fromJson(Map<String, dynamic> json) {
    return RegionalBdmDashboardAdapterDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
