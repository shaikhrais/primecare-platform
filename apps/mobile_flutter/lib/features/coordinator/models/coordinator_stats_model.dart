class CoordinatorStatsData {
  final int livePsw;
  final int sosActive;
  final int pendingMatches;
  final int waitlistCount;

  CoordinatorStatsData({
    required this.livePsw,
    required this.sosActive,
    required this.pendingMatches,
    required this.waitlistCount,
  });

  factory CoordinatorStatsData.fromJson(Map<String, dynamic> json) {
    return CoordinatorStatsData(
      livePsw: json['livePsw'] as int? ?? 0,
      sosActive: json['sosActive'] as int? ?? 0,
      pendingMatches: json['pendingMatches'] as int? ?? 0,
      waitlistCount: json['waitlistCount'] as int? ?? 0,
    );
  }
}
