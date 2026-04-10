class TrainingDirectorDashboardDto {
  final List<dynamic> rawKpis;

  const TrainingDirectorDashboardDto({
    required this.rawKpis,
  });

  factory TrainingDirectorDashboardDto.fromJson(Map<String, dynamic> json) {
    return TrainingDirectorDashboardDto(
      rawKpis: json['kpis'] ?? [],
    );
  }
}
