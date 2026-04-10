class SchedulerDashboardDto {
  final List<dynamic> rawKpis;

  SchedulerDashboardDto({required this.rawKpis});

  factory SchedulerDashboardDto.fromJson(Map<String, dynamic> json) {
    return SchedulerDashboardDto(rawKpis: json['kpis'] ?? []);
  }
}
