import 'dart:async';
import 'package:primecare_core/primecare_core.dart';
import 'package:test/test.dart';

class RecordingSentinel extends BaseSecuritySentinelService {
  final messages = <(String, String)>[];
  final lengthsAtLog = <int>[];
  Object? failure;
  void record(String severity, String message) {
    messages.add((severity, message));
    lengthsAtLog.add(eventLog.length);
    if (failure != null) throw failure!;
  }

  @override
  void logError(String message) => record('error', message);
  @override
  void logWarning(String message) => record('warning', message);
  @override
  void logInfo(String message) => record('info', message);
}

SecurityEvent event(int id, SecurityEventSeverity severity) => SecurityEvent(
  id: '$id',
  timestamp: DateTime.utc(2026),
  type: 'TEST',
  description: 'event $id',
  severity: severity,
);
void main() {
  test(
    'severity messages and broadcast dispatch preserve event identity',
    () async {
      final service = RecordingSentinel();
      final first = <SecurityEvent>[];
      final second = <SecurityEvent>[];
      final sub1 = service.eventStream.listen(first.add);
      final sub2 = service.eventStream.listen(second.add);
      final events = [
        event(1, SecurityEventSeverity.critical),
        event(2, SecurityEventSeverity.warning),
        event(3, SecurityEventSeverity.info),
      ];
      for (final item in events) {
        service.reportEvent(item);
      }
      await Future<void>.delayed(Duration.zero);
      expect(first, events);
      expect(second, events);
      expect(first.first, same(events.first));
      expect(service.messages, [
        ('error', 'CRITICAL SECURITY EVENT: event 1'),
        ('warning', 'Security Warning: event 2'),
        ('info', 'Security Event: event 3'),
      ]);
      await sub1.cancel();
      await sub2.cancel();
    },
  );
  test('retention keeps latest 500 after logging with immutable snapshots', () {
    final service = RecordingSentinel();
    final snapshot = service.eventLog;
    for (var i = 0; i < 502; i++) {
      service.reportEvent(event(i, SecurityEventSeverity.info));
    }
    expect(service.eventLog.length, 500);
    expect(service.eventLog.first.id, '2');
    expect(service.eventLog.last.id, '501');
    expect(service.lengthsAtLog.last, 501);
    expect(snapshot, isEmpty);
    expect(() => service.eventLog.clear(), throwsUnsupportedError);
  });
  test('all convenience builders preserve payloads and severities', () {
    final service = RecordingSentinel();
    service.reportMetricViolation('cpu', 'high');
    service.reportIntegrityFailure('hash');
    service.reportMfaFailure('otp', 'expired');
    service.reportTrustedDeviceViolation('device');
    service.reportUnauthorizedAccess('record');
    expect(service.eventLog.map((e) => e.type), [
      'METRIC_VIOLATION',
      'INTEGRITY_FAILURE',
      'MFA_FAILURE',
      'TRUSTED_DEVICE_VIOLATION',
      'UNAUTHORIZED_ACCESS',
    ]);
    expect(service.eventLog.map((e) => e.description), [
      'Violation in cpu: high',
      'Environment integrity check failed: hash',
      'MFA failure (otp): expired',
      'Access attempt from untrusted device: device',
      'Unauthorized access attempt to: record',
    ]);
    expect(service.eventLog.map((e) => e.severity), [
      SecurityEventSeverity.warning,
      SecurityEventSeverity.critical,
      SecurityEventSeverity.warning,
      SecurityEventSeverity.warning,
      SecurityEventSeverity.critical,
    ]);
    expect(
      service.eventLog.every(
        (e) => int.tryParse(e.id) != null && e.metadata == null,
      ),
      isTrue,
    );
  });
  test(
    'logger failure follows insertion and dispatch before retention',
    () async {
      final error = StateError('logger');
      final service = RecordingSentinel();
      for (var i = 0; i < 500; i++) {
        service.reportEvent(event(i, SecurityEventSeverity.info));
      }
      service.failure = error;
      final next = service.eventStream.first;
      final item = event(500, SecurityEventSeverity.warning);
      expect(() => service.reportEvent(item), throwsA(same(error)));
      expect(service.eventLog.length, 501);
      expect(await next, same(item));
    },
  );
}
