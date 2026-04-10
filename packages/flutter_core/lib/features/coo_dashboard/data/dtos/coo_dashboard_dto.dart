class CooDashboardDto {
  final List<dynamic> rawKpis;

  CooDashboardDto({required this.rawKpis});

  factory CooDashboardDto.fromJson(Map<String, dynamic> json) {
    return CooDashboardDto(rawKpis: json['kpis'] ?? []);
  }
}
