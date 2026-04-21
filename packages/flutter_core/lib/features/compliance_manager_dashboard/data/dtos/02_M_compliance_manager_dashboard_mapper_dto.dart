// Layer: 02_MODELS_FOUNDATION
class ComplianceManagerDashboardMapperDto {
  final String id;
  final Map<String, dynamic> raw;

  ComplianceManagerDashboardMapperDto({required this.id, required this.raw});

  factory ComplianceManagerDashboardMapperDto.fromJson(Map<String, dynamic> json) {
    return ComplianceManagerDashboardMapperDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

