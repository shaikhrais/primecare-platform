class ClinicDashboardDto {
  final List<dynamic> rawKpis;

  ClinicDashboardDto({required this.rawKpis});

  factory ClinicDashboardDto.fromJson(Map<String, dynamic> json) {
    return ClinicDashboardDto(rawKpis: json['kpis'] ?? []);
  }
}
