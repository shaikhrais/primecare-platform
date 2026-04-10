class CustomerSupportDashboardDto {
  final List<dynamic> rawKpis;

  CustomerSupportDashboardDto({required this.rawKpis});

  factory CustomerSupportDashboardDto.fromJson(Map<String, dynamic> json) {
    return CustomerSupportDashboardDto(rawKpis: json['kpis'] ?? []);
  }
}
