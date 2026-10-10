import 'package:primecare_models/primecare_models.dart';
import 'package:test/test.dart';

class Fallback implements OfflineFallbackState {
  @override
  final bool isOfflineFallback;
  Fallback(this.isOfflineFallback);
}

void main() {
  test('Result guard and fold preserve success identity', () {
    final Result<int> value = Result.guard(() => 42);
    expect(value, isA<Success<int>>());
    expect(value.getOrThrow(), 42);
    expect(value.fold((data) => data.toString(), (error) => 'failed'), '42');
    final OfflineFallbackState fallback = Fallback(true);
    expect(fallback.isOfflineFallback, isTrue);
  });

  test(
    'Result failures preserve the thrown object through fold and rethrow',
    () {
      final error = StateError('failed');
      final value = Result.guard<int>(() => throw error);
      expect(value, isA<Failure<int>>());
      expect(value.fold((data) => null, (failure) => failure), same(error));
      expect(value.getOrThrow, throwsA(same(error)));
    },
  );

  test(
    'synchronous fallback preserves original error and fallback failure',
    () {
      final original = StateError('original');
      final inner = StateError('fallback');
      final recovered = Result.guard<int>(
        () => throw original,
        onError: (error, stack) {
          expect(error, same(original));
          expect(stack.toString(), isNotEmpty);
          return 12;
        },
      );
      expect(recovered.getOrThrow(), 12);
      final failed = Result.guard<int>(
        () => throw original,
        onError: (error, stack) => throw inner,
      );
      expect(failed.getOrThrow, throwsA(same(inner)));
    },
  );

  test(
    'async guard handles values, async errors and async fallback errors',
    () async {
      expect((await Result.guardFuture(() => 4)).getOrThrow(), 4);
      expect((await Result.guardFuture(() async => 5)).getOrThrow(), 5);
      final original = StateError('original');
      final inner = StateError('fallback');
      final failed = await Result.guardFuture<int>(() async => throw original);
      expect(failed.getOrThrow, throwsA(same(original)));
      final recovered = await Result.guardFuture<int>(
        () async => throw original,
        onError: (error, stack) async {
          expect(error, same(original));
          return 6;
        },
      );
      expect(recovered.getOrThrow(), 6);
      final failedFallback = await Result.guardFuture<int>(
        () => throw original,
        onError: (error, stack) async => throw inner,
      );
      expect(failedFallback.getOrThrow, throwsA(same(inner)));
    },
  );

  test(
    'API response preserves HTTP success boundaries and payload identity',
    () {
      final payload = {'value': 7};
      for (final status in [199, 200, 204, 299, 300, 401, 500]) {
        final response = ApiResponse(
          data: payload,
          statusCode: status,
          error: 'message',
        );
        expect(response.isSuccess, status >= 200 && status < 300);
        expect(response.data, same(payload));
        expect(response.error, 'message');
      }
    },
  );

  test('integrity and posture retain every existing security decision', () {
    for (var flags = 0; flags < 32; flags++) {
      final integrity = AppIntegrityStatus(
        isRooted: flags & 1 != 0,
        isJailbroken: flags & 2 != 0,
        isEmulator: flags & 4 != 0,
        isTampered: flags & 8 != 0,
        isDevelopmentMode: flags & 16 != 0,
      );
      final secure = flags & 15 == 0;
      expect(integrity.isSecure, secure);
      for (final authenticated in [false, true]) {
        for (final trusted in [false, true]) {
          for (final mfa in MfaStatus.values) {
            final posture = SecurityPosture(
              isAuthenticated: authenticated,
              isDeviceTrusted: trusted,
              mfaStatus: mfa,
              integrity: integrity,
            );
            expect(
              posture.isFullySecure,
              authenticated && trusted && mfa == MfaStatus.verified && secure,
            );
          }
        }
      }
    }
    expect(
      SecurityViolationException('blocked').toString(),
      'SecurityViolationException: blocked',
    );
  });

  test(
    'telemetry and Aura event keep fields, defaults and enum identities',
    () {
      final now = DateTime.now();
      final telemetry = TelemetryData(
        cpuUsage: 12,
        memoryUsage: 34,
        activeRequests: 5,
        timestamp: now,
      );
      expect(
        [
          telemetry.cpuUsage,
          telemetry.memoryUsage,
          telemetry.activeRequests,
          telemetry.timestamp,
        ],
        [12, 34, 5, now],
      );
      final stable = AuraEvent.stable();
      expect(stable.id, 'stable');
      expect(stable.type, AuraEventType.stable);
      expect(stable.impact, InsightImpact.info);
      expect(stable.isPredictive, isFalse);
      expect(stable.metadata, isNull);
      expect(stable.title, 'aura.events.stable_title');
      expect(stable.description, 'aura.events.stable_desc');
      expect(ExecutionGateCategory.values.map((e) => e.name), [
        'auth',
        'database',
        'network',
        'ui',
        'intelligence',
        'auraEngine',
        'aura',
        'governance',
        'metricsLayer',
        'scheduler',
        'navigationLayer',
        'resilience',
        'structuralIntegrity',
        'domainApi',
        'storage',
      ]);
      expect(SecurityRequirement.values.map((e) => e.name), [
        'authenticated',
        'trustedDevice',
        'activeMfa',
        'bankGrade',
      ]);
    },
  );

  test('shared form inheritance and governance decisions preserve data', () {
    final field = TextFieldSchema(
      id: 'name',
      label: 'Name',
      placeholder: 'Enter name',
    );
    final fields = <SchemaField>[field];
    final schema = FormSchema<Map<String, dynamic>>(
      title: 'Profile',
      fields: fields,
    );
    expect(schema.fields, same(fields));
    expect(schema.fields.single, same(field));
    expect(
      [field.id, field.label, field.placeholder],
      ['name', 'Name', 'Enter name'],
    );
    expect(TextFieldSchema(id: 'other', label: 'Other').placeholder, isNull);
    expect(GuardResult(true).redirectRoute, isNull);
    final denied = GuardResult(false, redirectRoute: '/login');
    expect(denied.isAllowed, isFalse);
    expect(denied.redirectRoute, '/login');
    final parity = ParityResult(screenId: 'screen', isCompliant: true);
    expect(parity.missingApis, isEmpty);
    expect(parity.mismatchingApis, isEmpty);
    final missing = ['api'];
    final failing = ParityResult(
      screenId: 'screen',
      isCompliant: false,
      missingApis: missing,
    );
    expect(failing.missingApis, same(missing));
    expect(failing.isCompliant, isFalse);
  });
}
