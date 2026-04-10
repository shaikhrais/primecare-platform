class GeneralManagerDashboardDto {
  final List<dynamic> rawKpis;

  GeneralManagerDashboardDto({required this.rawKpis});

  factory GeneralManagerDashboardDto.fromJson(Map<String, dynamic> json) {
    return GeneralManagerDashboardDto(rawKpis: json['kpis'] ?? []);
  }
}
