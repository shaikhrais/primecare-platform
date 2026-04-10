class CeoDashboardDto {
  final double ytdRevenue;
  final int totalFacilities;
  final int activeStaff;
  final int criticalAlerts;
  final List<dynamic> rawActivities; // Can map to a strictly typed DTO sub-class if needed

  CeoDashboardDto({
    required this.ytdRevenue,
    required this.totalFacilities,
    required this.activeStaff,
    required this.criticalAlerts,
    this.rawActivities = const [],
  });

  factory CeoDashboardDto.fromJson(Map<String, dynamic> json) {
    return CeoDashboardDto(
      ytdRevenue: (json['ytdRevenue'] ?? 0).toDouble(),
      totalFacilities: json['totalFacilities'] ?? 0,
      activeStaff: json['activeStaff'] ?? 0,
      criticalAlerts: json['criticalAlerts'] ?? 0,
      rawActivities: json['recentActivity'] ?? [],
    );
  }
}
