class RegionalManagerUsaDashboardDto {
  final List<dynamic> rawKpis;

  RegionalManagerUsaDashboardDto({required this.rawKpis});

  factory RegionalManagerUsaDashboardDto.fromJson(Map<String, dynamic> json) {
    return RegionalManagerUsaDashboardDto(rawKpis: json['kpis'] ?? []);
  }
}
