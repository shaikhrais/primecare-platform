class CtoDashboardDto {
  final List<dynamic> rawKpis;

  CtoDashboardDto({required this.rawKpis});

  factory CtoDashboardDto.fromJson(Map<String, dynamic> json) {
    return CtoDashboardDto(rawKpis: json['kpis'] ?? []);
  }
}
