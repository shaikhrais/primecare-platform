class AdminStatsData {
  final int totalUsers;
  final int pendingVisits;
  final int totalVisits;
  final int totalLeads;
  final double modelScore;

  AdminStatsData({
    required this.totalUsers,
    required this.pendingVisits,
    required this.totalVisits,
    required this.totalLeads,
    required this.modelScore,
  });

  factory AdminStatsData.fromJson(Map<String, dynamic> json) {
    return AdminStatsData(
      totalUsers: json['totalUsers'] as int? ?? 0,
      pendingVisits: json['pendingVisits'] as int? ?? 0,
      totalVisits: json['totalVisits'] as int? ?? 0,
      totalLeads: json['totalLeads'] as int? ?? 0,
      modelScore: (json['modelScore'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
