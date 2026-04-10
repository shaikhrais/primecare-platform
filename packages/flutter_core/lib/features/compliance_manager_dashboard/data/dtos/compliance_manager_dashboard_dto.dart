class ComplianceManagerDashboardDto {
  final List<dynamic> rawKpis;
  final List<dynamic> rawRecentActivity;

  const ComplianceManagerDashboardDto({
    required this.rawKpis,
    this.rawRecentActivity = const [],
  });

  factory ComplianceManagerDashboardDto.fromJson(Map<String, dynamic> json) {
    return ComplianceManagerDashboardDto(
      rawKpis: json['kpis'] ?? [],
      rawRecentActivity: json['recentActivity'] ?? [],
    );
  }
}
