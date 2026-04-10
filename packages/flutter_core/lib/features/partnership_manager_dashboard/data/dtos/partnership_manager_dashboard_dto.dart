class PartnershipManagerDashboardDto {
  final List<dynamic> rawKpis;

  PartnershipManagerDashboardDto({required this.rawKpis});

  factory PartnershipManagerDashboardDto.fromJson(Map<String, dynamic> json) {
    return PartnershipManagerDashboardDto(rawKpis: json['kpis'] ?? []);
  }
}
