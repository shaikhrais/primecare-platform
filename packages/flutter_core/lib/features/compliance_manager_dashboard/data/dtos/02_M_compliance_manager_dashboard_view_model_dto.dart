// Layer: 02_MODELS_FOUNDATION
class ComplianceManagerDashboardViewModelDto {
  final String id;
  final Map<String, dynamic> raw;

  ComplianceManagerDashboardViewModelDto({required this.id, required this.raw});

  factory ComplianceManagerDashboardViewModelDto.fromJson(Map<String, dynamic> json) {
    return ComplianceManagerDashboardViewModelDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

