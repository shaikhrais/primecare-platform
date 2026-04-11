class LocalMarketingManagerDashboardDto {
  final List<dynamic> rawKpis;

  LocalMarketingManagerDashboardDto({required this.rawKpis});

  factory LocalMarketingManagerDashboardDto.fromJson(
    Map<String, dynamic> json,
  ) {
    return LocalMarketingManagerDashboardDto(rawKpis: json['kpis'] ?? []);
  }
}
