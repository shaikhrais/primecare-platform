import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_demo_telemetry/primecare_demo_telemetry.dart';
void main() { test('synthetic health sample remains in fixture bounds', () async { final sample = await TelemetryService().streamSystemHealth().first; expect(sample.cpuUsage, inInclusiveRange(20, 60)); expect(sample.memoryUsage, inInclusiveRange(50, 80)); expect(sample.activeRequests, inInclusiveRange(100, 599)); }); }
