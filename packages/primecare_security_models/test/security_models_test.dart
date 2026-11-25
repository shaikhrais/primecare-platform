import 'package:primecare_security_models/primecare_security_models.dart';
import 'package:test/test.dart';

void main() {
  test('device and event value objects preserve identity and serialization', () {
    const a = DeviceFingerprint(uuid: 'fixture', model: 'sample', osVersion: '1');
    expect(a, const DeviceFingerprint(uuid: 'fixture', model: 'sample', osVersion: '1'));
    expect(a, isNot(const DeviceFingerprint(uuid: 'fixture2', model: 'sample', osVersion: '1')));
    final time = DateTime.utc(2026, 11, 25);
    final event = SecurityEvent(id: 'fixture', timestamp: time, type: 'fixture', description: 'Synthetic event', severity: SecurityEventSeverity.info);
    expect(event.toJson()['timestamp'], time.toIso8601String());
    expect(event.toJson()['severity'], 'info');
  });
}
