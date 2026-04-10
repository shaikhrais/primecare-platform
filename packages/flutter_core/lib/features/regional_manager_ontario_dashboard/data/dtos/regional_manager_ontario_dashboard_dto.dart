class RegionalManagerOntarioDashboardDto {
  final List<dynamic> rawKpis;

  const RegionalManagerOntarioDashboardDto({
    required this.rawKpis,
  });

  factory RegionalManagerOntarioDashboardDto.fromJson(Map<String, dynamic> json) {
    return RegionalManagerOntarioDashboardDto(
      rawKpis: json['kpis'] ?? [],
    );
  }
}
