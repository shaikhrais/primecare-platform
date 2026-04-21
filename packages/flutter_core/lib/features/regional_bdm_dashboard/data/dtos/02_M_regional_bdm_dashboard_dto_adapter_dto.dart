// Layer: 02_MODELS_FOUNDATION
class RegionalBdmDashboardDtoAdapterDto {
  final String id;
  final Map<String, dynamic> raw;

  RegionalBdmDashboardDtoAdapterDto({required this.id, required this.raw});

  factory RegionalBdmDashboardDtoAdapterDto.fromJson(Map<String, dynamic> json) {
    return RegionalBdmDashboardDtoAdapterDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
