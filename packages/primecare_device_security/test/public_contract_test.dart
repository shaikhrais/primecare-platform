import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_device_security/primecare_device_security.dart';

void main() {
  test('named package retains the public service contracts', () {
    expect(IMfaService, isNotNull);
    expect(ITrustedDeviceService, isNotNull);
    expect(SecurityOrchestrator, isNotNull);
    expect(SecuritySentinelService, isNotNull);
    expect(ScreenShieldService, isNotNull);
    expect(SensitiveActionGuard, isNotNull);
    expect(AppIntegrityService, isNotNull);
  });
}
