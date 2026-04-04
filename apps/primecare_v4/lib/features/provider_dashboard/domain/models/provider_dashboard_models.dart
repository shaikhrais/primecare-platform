class ProviderDashboardViewModel {
  final String providerName;
  final int todayVisits;
  final List<String> alerts;
  final String? nextVisitTime;

  ProviderDashboardViewModel({
    required this.providerName,
    required this.todayVisits,
    required this.alerts,
    this.nextVisitTime,
  });
}

class ProviderDashboardDto {
  final String fullName;
  final int todayVisits;
  final List<String> alerts;
  final String? nextVisitTime;

  ProviderDashboardDto({
    required this.fullName,
    required this.todayVisits,
    required this.alerts,
    this.nextVisitTime,
  });

  factory ProviderDashboardDto.fromJson(Map<String, dynamic> json) {
    return ProviderDashboardDto(
      fullName: json['fullName'] ?? json['provider_name'] ?? '',
      todayVisits: json['todayVisits'] ?? 0,
      alerts: List<String>.from(json['alerts'] ?? []),
      nextVisitTime: json['nextVisit']?['time'],
    );
  }
}
