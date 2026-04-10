class RegionalManagerUsaDashboardDto {
  final List<dynamic> rawKpis;

  const RegionalManagerUsaDashboardDto({required this.rawKpis});

  factory RegionalManagerUsaDashboardDto.fromJson(Map<String, dynamic> json) {
    return RegionalManagerUsaDashboardDto(rawKpis: json['kpis'] ?? []);
  }
}
