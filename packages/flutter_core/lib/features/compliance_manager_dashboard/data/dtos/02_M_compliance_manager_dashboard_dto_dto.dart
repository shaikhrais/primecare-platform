// Layer: 02_MODELS_FOUNDATION
class ComplianceManagerDashboardDtoDto {
  final String id;
  final Map<String, dynamic> raw;

  ComplianceManagerDashboardDtoDto({required this.id, required this.raw});

  factory ComplianceManagerDashboardDtoDto.fromJson(Map<String, dynamic> json) {
    return ComplianceManagerDashboardDtoDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

