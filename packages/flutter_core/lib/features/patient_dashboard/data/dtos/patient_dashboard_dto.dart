class PatientDashboardDto {
  final List<dynamic> rawKpis;

  const PatientDashboardDto({required this.rawKpis});

  factory PatientDashboardDto.fromJson(Map<String, dynamic> json) {
    return PatientDashboardDto(rawKpis: json['kpis'] ?? []);
  }
}
