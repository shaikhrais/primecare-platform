import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_execution_gate/primecare_execution_gate.dart';
import 'package:primecare_guarded_service/primecare_guarded_service.dart';
import 'package:primecare_models/primecare_models.dart';
class FixtureService extends BaseGuardedService { FixtureService(super.telemetry); }
void main() { test('guard preserves success and error result', () async { final service=FixtureService(ExecutionGateService());expect((await service.guard(()=>7)).getOrThrow(),7);expect(await service.guard<int>(()=>throw StateError('fixture')),isA<Failure<int>>()); }); }
