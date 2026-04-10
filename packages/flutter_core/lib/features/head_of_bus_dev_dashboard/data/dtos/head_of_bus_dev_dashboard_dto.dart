class HeadOfBusDevDashboardDto {
  final List<dynamic> rawKpis;

  HeadOfBusDevDashboardDto({required this.rawKpis});

  factory HeadOfBusDevDashboardDto.fromJson(Map<String, dynamic> json) {
    return HeadOfBusDevDashboardDto(rawKpis: json['kpis'] ?? []);
  }
}
