class IntakeDashboardDto {
  final List<dynamic> rawKpis;

  const IntakeDashboardDto({
    required this.rawKpis,
  });

  factory IntakeDashboardDto.fromJson(Map<String, dynamic> json) {
    return IntakeDashboardDto(
      rawKpis: json['kpis'] ?? [],
    );
  }
}
