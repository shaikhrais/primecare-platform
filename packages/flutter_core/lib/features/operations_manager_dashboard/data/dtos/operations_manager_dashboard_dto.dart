class OperationsManagerDashboardDto {
  final List<dynamic> rawKpis;

  OperationsManagerDashboardDto({required this.rawKpis});

  factory OperationsManagerDashboardDto.fromJson(Map<String, dynamic> json) {
    return OperationsManagerDashboardDto(rawKpis: json['kpis'] ?? []);
  }
}
