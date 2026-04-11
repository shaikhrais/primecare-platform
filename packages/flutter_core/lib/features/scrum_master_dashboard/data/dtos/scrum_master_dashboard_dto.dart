class ScrumMasterDashboardDto {
  final List<dynamic> rawKpis;

  const ScrumMasterDashboardDto({required this.rawKpis});

  factory ScrumMasterDashboardDto.fromJson(Map<String, dynamic> json) {
    return ScrumMasterDashboardDto(rawKpis: json['kpis'] ?? []);
  }
}
