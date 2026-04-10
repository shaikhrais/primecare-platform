class FamilyDashboardDto {
  final List<dynamic> rawKpis;

  FamilyDashboardDto({required this.rawKpis});

  factory FamilyDashboardDto.fromJson(Map<String, dynamic> json) {
    return FamilyDashboardDto(rawKpis: json['kpis'] ?? []);
  }
}
