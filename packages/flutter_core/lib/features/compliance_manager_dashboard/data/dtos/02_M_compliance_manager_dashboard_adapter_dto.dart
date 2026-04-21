// Layer: 02_MODELS_FOUNDATION
class ComplianceManagerDashboardAdapterDto {
  final String id;
  final Map<String, dynamic> raw;

  ComplianceManagerDashboardAdapterDto({required this.id, required this.raw});

  factory ComplianceManagerDashboardAdapterDto.fromJson(Map<String, dynamic> json) {
    return ComplianceManagerDashboardAdapterDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
