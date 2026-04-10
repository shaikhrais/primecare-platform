class QaDashboardDto {
  final List<dynamic> rawKpis;

  const QaDashboardDto({
    required this.rawKpis,
  });

  factory QaDashboardDto.fromJson(Map<String, dynamic> json) {
    return QaDashboardDto(
      rawKpis: json['kpis'] ?? [],
    );
  }
}
