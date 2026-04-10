class CommunityOutreachDashboardDto {
  final List<dynamic> rawKpis;

  CommunityOutreachDashboardDto({required this.rawKpis});

  factory CommunityOutreachDashboardDto.fromJson(Map<String, dynamic> json) {
    return CommunityOutreachDashboardDto(rawKpis: json['kpis'] ?? []);
  }
}
