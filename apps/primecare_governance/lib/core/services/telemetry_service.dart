import 'dart:async';
import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

class TelemetryService {
  final _random = Random();
  
  Stream<TelemetryData> streamSystemHealth() async* {
    while (true) {
      await Future.delayed(const Duration(seconds: 2));
      yield TelemetryData(
        cpuUsage: 20 + _random.nextDouble() * 40,
        memoryUsage: 50 + _random.nextDouble() * 30,
        activeRequests: 100 + _random.nextInt(500),
        timestamp: DateTime.now(),
      );
    }
  }
}

final telemetryServiceProvider = Provider((ref) => TelemetryService());

final systemHealthProvider = StreamProvider<TelemetryData>((ref) {
  final service = ref.watch(telemetryServiceProvider);
  return service.streamSystemHealth();
});
