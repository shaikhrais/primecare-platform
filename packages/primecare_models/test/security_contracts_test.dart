import 'package:primecare_models/primecare_models.dart';
import 'package:test/test.dart';

void main() {
  test('security event retains wire keys, timestamp and value equality', () {
    final time = DateTime.utc(2026, 10, 10);
    final event = SecurityEvent(id: 'e1', timestamp: time, type: 'login',
        description: 'Login recorded', severity: SecurityEventSeverity.info,
        metadata: {'tenantId': 't1'});
    expect(event.toJson(), {'id': 'e1', 'timestamp': time.toIso8601String(),
      'type': 'login', 'description': 'Login recorded', 'severity': 'info',
      'metadata': {'tenantId': 't1'}});
    expect(event, SecurityEvent(id: 'e1', timestamp: time, type: 'login',
        description: 'Login recorded', severity: SecurityEventSeverity.info,
        metadata: {'tenantId': 't1'}));
  });

  test('fingerprint preserves defaults and equality fields', () {
    const fingerprint = DeviceFingerprint(uuid: 'd1', model: 'Phone', osVersion: '1');
    expect(fingerprint.isPhysical, isTrue);
    expect(fingerprint.metadata, isEmpty);
    expect(fingerprint, const DeviceFingerprint(uuid: 'd1', model: 'Phone', osVersion: '1'));
    expect(fingerprint, isNot(const DeviceFingerprint(uuid: 'd2', model: 'Phone', osVersion: '1')));
  });

  test('MFA challenge preserves expiration and method/status names', () {
    expect(MfaChallenge(challengeId: 'old', method: MfaMethod.email,
      expiresAt: DateTime.utc(2000)).isExpired, isTrue);
    expect(MfaChallenge(challengeId: 'future', method: MfaMethod.totp,
      expiresAt: DateTime.utc(2200)).isExpired, isFalse);
    expect(MfaMethod.values.map((v) => v.name), ['totp', 'sms', 'email', 'biometric']);
    expect(MfaStatus.values.map((v) => v.name),
      ['notStarted', 'pending', 'verified', 'failed', 'expired']);
    expect(TrustLevel.values.map((v) => v.name), ['untrusted', 'temporary', 'trusted', 'revoked']);
  });
}
