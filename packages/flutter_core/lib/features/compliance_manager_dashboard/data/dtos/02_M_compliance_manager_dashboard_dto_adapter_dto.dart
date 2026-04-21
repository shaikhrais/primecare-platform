// Layer: 02_MODELS_FOUNDATION
class ComplianceManagerDashboardDtoAdapterDto {
  final String id;
  final Map<String, dynamic> raw;

  ComplianceManagerDashboardDtoAdapterDto({required this.id, required this.raw});

  factory ComplianceManagerDashboardDtoAdapterDto.fromJson(Map<String, dynamic> json) {
    return ComplianceManagerDashboardDtoAdapterDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
