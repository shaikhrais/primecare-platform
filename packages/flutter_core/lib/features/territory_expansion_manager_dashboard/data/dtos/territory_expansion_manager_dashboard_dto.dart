class TerritoryExpansionManagerDashboardDto {
  final List<dynamic> rawKpis;

  TerritoryExpansionManagerDashboardDto({required this.rawKpis});

  factory TerritoryExpansionManagerDashboardDto.fromJson(Map<String, dynamic> json) {
    return TerritoryExpansionManagerDashboardDto(rawKpis: json['kpis'] ?? []);
  }
}
