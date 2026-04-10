class HrHiringDashboardDto {
  final List<dynamic> rawKpis;

  HrHiringDashboardDto({required this.rawKpis});

  factory HrHiringDashboardDto.fromJson(Map<String, dynamic> json) {
    return HrHiringDashboardDto(rawKpis: json['kpis'] ?? []);
  }
}
