import 'package:primecare_core/primecare_core.dart';
import 'package:test/test.dart';

class DemoTelemetry extends BaseSimulatedTelemetryService {}

void main() {
  test('existing demo stream retains delay ranges and timestamp', () async {
    final start = DateTime.now();
    final data = await DemoTelemetry().streamSystemHealth().first;
    expect(data.cpuUsage, inInclusiveRange(20, 60));
    expect(data.memoryUsage, inInclusiveRange(50, 80));
    expect(data.activeRequests, inInclusiveRange(100, 599));
    expect(data.timestamp.isBefore(start), isFalse);
    expect(
      data.timestamp.difference(start).inMilliseconds,
      greaterThanOrEqualTo(1900),
    );
  });
}
