class ClientDashboardDto {
  final List<dynamic> rawKpis;

  ClientDashboardDto({required this.rawKpis});

  factory ClientDashboardDto.fromJson(Map<String, dynamic> json) {
    return ClientDashboardDto(rawKpis: json['kpis'] ?? []);
  }
}
