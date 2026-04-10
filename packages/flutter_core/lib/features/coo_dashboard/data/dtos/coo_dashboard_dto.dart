class CooDashboardDto {
  final int activeShifts;
  final double fulfillmentRate;
  final double complianceScore;
  final int criticalIncidents;

  CooDashboardDto({
    required this.activeShifts,
    required this.fulfillmentRate,
    required this.complianceScore,
    required this.criticalIncidents,
  });

  factory CooDashboardDto.fromJson(Map<String, dynamic> json) {
    return CooDashboardDto(
      activeShifts: json['activeShifts'] ?? 0,
      fulfillmentRate: (json['fulfillmentRate'] ?? 0).toDouble(),
      complianceScore: (json['complianceScore'] ?? 0).toDouble(),
      criticalIncidents: json['criticalIncidents'] ?? 0,
    );
  }
}
