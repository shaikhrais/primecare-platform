class BillingAdminDashboardDto {
  final List<dynamic> rawKpis;

  BillingAdminDashboardDto({required this.rawKpis});

  factory BillingAdminDashboardDto.fromJson(Map<String, dynamic> json) {
    return BillingAdminDashboardDto(rawKpis: json['kpis'] ?? []);
  }
}
