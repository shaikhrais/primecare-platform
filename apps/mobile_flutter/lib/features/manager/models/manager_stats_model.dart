class ManagerStatsData {
  final List<dynamic> shiftFulfillment;
  final List<dynamic> revenue;
  final List<dynamic> overtimeRisk;

  ManagerStatsData({
    required this.shiftFulfillment,
    required this.revenue,
    required this.overtimeRisk,
  });

  factory ManagerStatsData.fromJson(Map<String, dynamic> json) {
    return ManagerStatsData(
      shiftFulfillment: json['shiftFulfillment'] as List<dynamic>? ?? [],
      revenue: json['revenue'] as List<dynamic>? ?? [],
      overtimeRisk: json['overtimeRisk'] as List<dynamic>? ?? [],
    );
  }
}
