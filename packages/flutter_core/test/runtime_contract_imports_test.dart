import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/flutter_core.dart' as core;
import 'package:flutter_core/auth_service.dart' as auth;
import 'package:flutter_core/src/resilience/result.dart' as legacy;
import 'package:flutter_core/src/resilience/execution_gate_service.dart' as gate;
import 'package:primecare_models/primecare_models.dart' as shared;

void main() {
  test('legacy authentication import uses the canonical API state', () {
    final shared.AuthState state = auth.AuthState(token: 'existing-token');
    final shared.BaseAuthenticationState parent = state;
    expect(parent.token, 'existing-token');
    expect(state.copyWith(token: null).token, 'existing-token');
    expect(state.copyWith(), isA<auth.AuthState>());
    expect(core.authProvider, same(auth.authProvider));
    expect(core.authListenable, same(auth.authListenable));
  });
  test('legacy result types retain canonical success and failure identity', () {
    const shared.Result<int> success = legacy.Success<int>(7);
    expect(success, isA<shared.Success<int>>());
    expect(success.getOrThrow(), 7);
    final error = StateError('original');
    final shared.Result<int> failure = legacy.Failure<int>(error);
    expect((failure as shared.Failure<int>).error, same(error));
  });
  test('legacy telemetry event imports share canonical identity', () {
    final shared.AuraEvent event = gate.AuraEvent.stable();
    expect(event, isA<shared.BaseEntity<String>>());
    expect(event.type, shared.AuraEventType.stable);
    expect(gate.ExecutionGateCategory.auth, shared.ExecutionGateCategory.auth);
  });
}
