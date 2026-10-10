import 'dart:async';
import 'package:primecare_core/primecare_core.dart';
import 'package:test/test.dart';

class Gates extends BaseExecutionGateService {
  final logs = <String>[];
  @override
  void log(String message) => logs.add(message);
}

class Pulse extends BaseAuraPulseService {
  @override
  final Gates telemetry = Gates();
  @override
  DomainAuditResult performGovernanceAudit() => DomainAuditResult(
    totalRoles: 0,
    realizedRoles: [],
    pendingRoles: [],
    orphans: [],
    integrityScore: 100,
  );
}

void main() {
  test(
    'start emits initial stable signal to both broadcast listeners and stop closes',
    () async {
      final service = Pulse();
      final one = <AuraEvent>[];
      final two = <AuraEvent>[];
      final a = service.pulse.listen(one.add);
      final b = service.pulse.listen(two.add);
      service.start();
      await Future<void>.delayed(Duration.zero);
      expect(one.length, 1);
      expect(two.length, 1);
      expect(one.single, same(two.single));
      expect(one.single.type, AuraEvent.stable().type);
      expect(
        service.telemetry.logs.single,
        contains('Aura Heartbeat Service Started'),
      );
      service.stop();
      await Future<void>.delayed(Duration.zero);
      await a.cancel();
      await b.cancel();
    },
  );
  test(
    'repeated start retains two initial signals while replacing timer',
    () async {
      final service = Pulse();
      final values = <AuraEvent>[];
      final subscription = service.pulse.listen(values.add);
      service.start();
      service.start();
      await Future<void>.delayed(Duration.zero);
      expect(values.length, 2);
      expect(service.telemetry.logs.length, 2);
      service.stop();
      await subscription.cancel();
    },
  );
}
