import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_governance/core/governance/governance_api_service.dart';

void main() {
  test('unconfigured telemetry fetch cannot fabricate metrics', () async {
    await expectLater(GovernanceApiService().fetchLiveTelemetry(), throwsUnsupportedError);
  });

  test('unconfigured stream reports an error instead of simulated events', () async {
    await expectLater(GovernanceApiService().telemetryStream,
      emitsError(isA<UnsupportedError>()));
  });

  test('unconfigured commands never report work as executed', () async {
    for (final command in ['sync', 'lint', 'fix', 'anything']) {
      final result = await GovernanceApiService().executeAction(command);
      expect(result.success, isFalse);
      expect(result.error, 'GOVERNANCE_ACTION_TRANSPORT_NOT_CONFIGURED');
      expect(result.output, contains('not configured'));
    }
  });
}
