class CtoDashboardDto {
  final double systemUptime;
  final int activeConnections;
  final int errorRate;
  final double avgLatency;

  CtoDashboardDto({
    required this.systemUptime,
    required this.activeConnections,
    required this.errorRate,
    required this.avgLatency,
  });

  factory CtoDashboardDto.fromJson(Map<String, dynamic> json) {
    return CtoDashboardDto(
      systemUptime: (json['systemUptime'] ?? 0).toDouble(),
      activeConnections: json['activeConnections'] ?? 0,
      errorRate: json['errorRate'] ?? 0,
      avgLatency: (json['avgLatency'] ?? 0).toDouble(),
    );
  }
}
