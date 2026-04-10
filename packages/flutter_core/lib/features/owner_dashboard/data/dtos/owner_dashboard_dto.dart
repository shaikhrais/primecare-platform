class OwnerDashboardDto {
  final List<dynamic> rawKpis;

  OwnerDashboardDto({required this.rawKpis});

  factory OwnerDashboardDto.fromJson(Map<String, dynamic> json) {
    return OwnerDashboardDto(rawKpis: json['kpis'] ?? []);
  }
}
