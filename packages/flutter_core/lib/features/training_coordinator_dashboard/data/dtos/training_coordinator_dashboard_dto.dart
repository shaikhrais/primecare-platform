class TrainingCoordinatorDashboardDto {
  final List<dynamic> rawKpis;

  const TrainingCoordinatorDashboardDto({required this.rawKpis});

  factory TrainingCoordinatorDashboardDto.fromJson(Map<String, dynamic> json) {
    return TrainingCoordinatorDashboardDto(rawKpis: json['kpis'] ?? []);
  }
}
