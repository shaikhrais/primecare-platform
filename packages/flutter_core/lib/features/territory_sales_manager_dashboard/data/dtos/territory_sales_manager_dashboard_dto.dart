class TerritorySalesManagerDashboardDto {
  final List<dynamic> rawKpis;

  TerritorySalesManagerDashboardDto({required this.rawKpis});

  factory TerritorySalesManagerDashboardDto.fromJson(Map<String, dynamic> json) {
    return TerritorySalesManagerDashboardDto(rawKpis: json['kpis'] ?? []);
  }
}
