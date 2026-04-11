class CooDashboardDto {
  final int activeShifts;
  final double fulfillmentRate;
  final double complianceScore;
  final int criticalIncidents;

  final List<Map<String, dynamic>>? funnelSteps;
  final List<Map<String, dynamic>>? ganttTasks;

  CooDashboardDto({
    required this.activeShifts,
    required this.fulfillmentRate,
    required this.complianceScore,
    required this.criticalIncidents,
    this.funnelSteps,
    this.ganttTasks,
  });

  factory CooDashboardDto.fromJson(Map<String, dynamic> json) {
    return CooDashboardDto(
      activeShifts: json['activeShifts'] ?? 0,
      fulfillmentRate: (json['fulfillmentRate'] ?? 0).toDouble(),
      complianceScore: (json['complianceScore'] ?? 0).toDouble(),
      criticalIncidents: json['criticalIncidents'] ?? 0,
      funnelSteps: (json['funnelSteps'] as List<dynamic>?)?.map((e) => e as Map<String, dynamic>).toList(),
      ganttTasks: (json['ganttTasks'] as List<dynamic>?)?.map((e) => e as Map<String, dynamic>).toList(),
    );
  }
}
