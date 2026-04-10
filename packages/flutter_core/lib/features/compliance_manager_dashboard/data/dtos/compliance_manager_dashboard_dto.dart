class ComplianceManagerDashboardDto {
  final List<dynamic> rawKpis;

  ComplianceManagerDashboardDto({required this.rawKpis});

  factory ComplianceManagerDashboardDto.fromJson(Map<String, dynamic> json) {
    return ComplianceManagerDashboardDto(rawKpis: json['kpis'] ?? []);
  }
}
