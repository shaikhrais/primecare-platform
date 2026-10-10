class TelemetryData {
  final double cpuUsage;
  final double memoryUsage;
  final int activeRequests;
  final DateTime timestamp;

  TelemetryData({
    required this.cpuUsage,
    required this.memoryUsage,
    required this.activeRequests,
    required this.timestamp,
  });
}
