import 'package:primecare_models/primecare_models.dart';
import 'package:test/test.dart';

void main() {
  test('API consumes authentication state and inherited session defaults', () {
    final BaseAuthenticationState state = AuthState(token: 'existing');
    expect(state.isAuthenticated, isFalse);
    expect(state.isInitialized, isFalse);
    expect(state.token, 'existing');
    expect((state as AuthState).copyWith(token: null).token, 'existing');
    expect(state.copyWith(isAuthenticated: true).isAuthenticated, isTrue);
  });
  test('API consumes sealed results and async fallback without Flutter', () async {
    const Result<int> result = Success(7);
    final classification = switch (result) {
      Success<int>(:final data) => data,
      Failure<int>() => -1,
    };
    expect(classification, 7);
    final fallback = await Result.guardFuture<int>(
      () => throw StateError('original'), onError: (error, stack) async => 9,
    );
    expect(fallback.getOrThrow(), 9);
  });
  test('shared telemetry events retain metadata ownership and identity', () {
    final metadata = <String, dynamic>{'original': true};
    final event = AuraEvent(
      id: 'existing', type: AuraEventType.hydrationMetrics,
      title: 'Existing', description: 'Original', impact: InsightImpact.info,
      timestamp: DateTime.utc(2026), metadata: metadata,
    );
    final BaseEntity<String> entity = event;
    expect(entity.id, 'existing');
    expect(event.metadata, same(metadata));
    expect(event.isPredictive, isFalse);
    expect(ExecutionGateCategory.values.last, ExecutionGateCategory.storage);
  });
}
