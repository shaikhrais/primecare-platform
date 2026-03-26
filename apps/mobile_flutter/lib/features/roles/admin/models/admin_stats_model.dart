class AdminStatsData {
  final int totalVisits;
  final int openIncidents;
  final int unassignedShifts;
  final int totalLedgerEntries;
  final String timestamp;
  final String loadStatus;

  AdminStatsData({
    required this.totalVisits,
    required this.openIncidents,
    required this.unassignedShifts,
    required this.totalLedgerEntries,
    required this.timestamp,
    required this.loadStatus,
  });

  factory AdminStatsData.fromJson(Map<String, dynamic> json) {
    return AdminStatsData(
      totalVisits: json['totalVisits'] as int? ?? 0,
      openIncidents: json['openIncidents'] as int? ?? 0,
      unassignedShifts: json['unassignedShifts'] as int? ?? 0,
      totalLedgerEntries: json['totalLedgerEntries'] as int? ?? 0,
      timestamp: json['timestamp'] as String? ?? '',
      loadStatus: json['loadStatus'] as String? ?? 'UNKNOWN',
    );
  }
}
