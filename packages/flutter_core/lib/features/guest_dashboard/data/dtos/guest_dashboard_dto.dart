class GuestDashboardDto {
  final List<dynamic> rawKpis;

  const GuestDashboardDto({required this.rawKpis});

  factory GuestDashboardDto.fromJson(Map<String, dynamic> json) {
    return GuestDashboardDto(rawKpis: json['kpis'] ?? []);
  }
}
