class HeadOfMarketingDashboardDto {
  final List<dynamic> rawKpis;

  HeadOfMarketingDashboardDto({required this.rawKpis});

  factory HeadOfMarketingDashboardDto.fromJson(Map<String, dynamic> json) {
    return HeadOfMarketingDashboardDto(rawKpis: json['kpis'] ?? []);
  }
}
