class CeoDashboardDto {
  final List<dynamic> rawKpis;

  CeoDashboardDto({required this.rawKpis});

  factory CeoDashboardDto.fromJson(Map<String, dynamic> json) {
    return CeoDashboardDto(rawKpis: json['kpis'] ?? []);
  }
}
