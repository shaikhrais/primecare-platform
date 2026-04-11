class FranchiseSalesManagerDashboardDto {
  final List<dynamic> rawKpis;

  FranchiseSalesManagerDashboardDto({required this.rawKpis});

  factory FranchiseSalesManagerDashboardDto.fromJson(
    Map<String, dynamic> json,
  ) {
    return FranchiseSalesManagerDashboardDto(rawKpis: json['kpis'] ?? []);
  }
}
