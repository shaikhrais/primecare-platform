import 'dart:async';
import 'dart:math';
import 'package:primecare_models/primecare_models.dart';

/// Existing demo stream; these values are simulated, not measured system health.
abstract class BaseSimulatedTelemetryService {
  final _random = Random();

  Stream<TelemetryData> streamSystemHealth() async* {
    while (true) {
      await Future<void>.delayed(const Duration(seconds: 2));
      yield TelemetryData(
        cpuUsage: 20 + _random.nextDouble() * 40,
        memoryUsage: 50 + _random.nextDouble() * 30,
        activeRequests: 100 + _random.nextInt(500),
        timestamp: DateTime.now(),
      );
    }
  }
}
