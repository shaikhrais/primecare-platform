class SupportDashboardDto {
  final List<dynamic> rawKpis;

  const SupportDashboardDto({
    required this.rawKpis,
  });

  factory SupportDashboardDto.fromJson(Map<String, dynamic> json) {
    return SupportDashboardDto(
      rawKpis: json['kpis'] ?? [],
    );
  }
}
