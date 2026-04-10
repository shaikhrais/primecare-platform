class CfoDashboardDto {
  final List<dynamic> rawKpis;

  CfoDashboardDto({required this.rawKpis});

  factory CfoDashboardDto.fromJson(Map<String, dynamic> json) {
    return CfoDashboardDto(rawKpis: json['kpis'] ?? []);
  }
}
